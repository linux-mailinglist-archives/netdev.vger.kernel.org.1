Return-Path: <netdev+bounces-152650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BF9F5098
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35667AA5C2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E61FC11D;
	Tue, 17 Dec 2024 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="A5wWcXNO"
X-Original-To: netdev@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99D1FC113
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451121; cv=none; b=McgJpub+7muEl/dt7SiTO8Czm3wzm5hdwkb+nLNe87gdQcuD4AdedPiXsMrFQTd8zGHiZcCC3myC1LQDSyDRaogTkxvslFG4xxPzpOv8P6Pmly7rn1bKfMYfT+oPsdpIsQXK3/IItVHBCauXjkq4ySC7mtxIitraeajAb1F8GtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451121; c=relaxed/simple;
	bh=+sDpWVjLDBeBSjHRJ7joaJqh4lAqvOv3lpfPurbkbjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD40N/0hjoSzYSbcISNc/kEOdt7NcX0bLALM1YY9fqOMrvLYqeDeGi5Wja4TkykJ2FpMpOMyY5uOYXmVzCeyV7sKh09G80oE/vVr8NzgYgiEeerq6kMHlNKvlzMXK4irUoTgnDDjS2qHvhg5ITciHB+KE3DscOir46uXO6pZdsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=A5wWcXNO; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id NE1TtgRQVumtXNZxwt0xna; Tue, 17 Dec 2024 15:58:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id NZxvt24V0827nNZxvta4Fs; Tue, 17 Dec 2024 15:58:31 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=67619fa7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=GtNDhlRIH4u8wNL3EA3KcA==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=NADnHABVQi_v-tRIJv0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uZfLtnsGJf44tIM+Q6RRYwmZq5kswEScs/pdo66+oA4=; b=A5wWcXNOCgiywYJPfR0ZuW8nYZ
	gcv3VdK4TP8/lD0v1ZAoIcs3g/EGQlNCKzvO267+cRYd9kAlXulI91yV+8/eHkGJWXs52co+3sICI
	r49gKDtdN7Gk5Z7UmgY4KWqdfBoaHZ5YEB2nF+NHLoj/u6uqd4ogoJYrUP6n+2sDnYrze7NFzkjeI
	dUjvcqF9dWMKQItYyLt0Uvo9BJ/2zfP2vS2TNQwgU0nfY1uc/rFDpzAPXfbL/N+Jc0snRmYjmjtlN
	oEBRpoZKvV0n/cgIk7ait9Ghnvrii7uWcQtvt2CWJ1TlawROshXDbzdi446tRjo08mnF7cYt4gVpJ
	D7GIJZyg==;
Received: from [177.238.21.80] (port=2 helo=[192.168.0.21])
	by gator4166.hostgator.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tNZxu-003vsV-0c;
	Tue, 17 Dec 2024 09:58:30 -0600
Message-ID: <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
Date: Tue, 17 Dec 2024 09:58:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, cferris@google.com,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.21.80
X-Source-L: No
X-Exim-ID: 1tNZxu-003vsV-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.21]) [177.238.21.80]:2
X-Source-Auth: guzidine
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD975peaFfa4CtbRKJB6EMYsjthfWeXWqxQHNkLWjHgNqsjpO36HYXIQCjzYeHf/HY5zJSE6kiLLH12N7czHU3C7LPnNdreX68/yDbpO99hlBhdjp+EV
 E9mbJ1Jrvbl4VjcuyUpVcIcWpShGv3iljZJn8DBz76YEh+r/xEYdTsnuj3fKsNuFy0PW7of26sQY9G6uTuhhqGjRNpvIm/gyQ5k=



On 17/12/24 08:55, Alexander Lobakin wrote:
> From: Kees Cook <kees@kernel.org>
> Date: Mon, 16 Dec 2024 18:59:55 -0800
> 
>> This switches to using a manually constructed form of struct tagging
>> to avoid issues with C++ being unable to parse tagged structs within
>> anonymous unions, even under 'extern "C"':
>>
>>    ../linux/include/uapi/linux/pkt_cls.h:25124: error: ‘struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,’ invalid; an anonymous union may only have public non-static data members [-fpermissive]
> 
> I worked around that like this in the past: [0]
> As I'm not sure it would be fine to fix every such occurrence manually
> by open-coding.
> What do you think?

The thing is that, in this particular case, we need a struct tag to change
the type of an object in another struct. See:

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
index 9050568a034c..64663112cad8 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
@@ -242,7 +242,7 @@ struct cxgb4_next_header {
  	 * field's value to jump to next header such as IHL field
  	 * in IPv4 header.
  	 */
-	struct tc_u32_sel sel;
+	struct tc_u32_sel_hdr sel;
  	struct tc_u32_key key;
  	/* location of jump to make */
  	const struct cxgb4_match_field *jump;;

You can also take a look at the original series:

https://lore.kernel.org/linux-hardening/cover.1723586870.git.gustavoars@kernel.org/

Thanks
--
Gustavo



