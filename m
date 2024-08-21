Return-Path: <netdev+bounces-120717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C538A95A63C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2741F22034
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 20:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63019170A2E;
	Wed, 21 Aug 2024 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="f85blLN3"
X-Original-To: netdev@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41215855F
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273987; cv=none; b=r2tr5N0h9KBLOeycVaLyRZ3sgJHnEWwp5T+OqoJD7KAznq3Fz36EVBPDvoz32ZuTr/YqiTqDeEqHr+LMEVZt2YyOq4vxVsBRnwBErwkytVmqUzur2TiKzucKWk773k9NsV5zDWA0U0jUsOVxrhO75+R6OekgM/dmIC/qq4UbLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273987; c=relaxed/simple;
	bh=9gif0GfjOod6shtBfqFq4ki+vojZHHi1MLbdU0xoS08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fm8J4zRn0TlvQax0yLY1vmh8AGS7+K+HIEuh+c8aOCtL498T92OF2BowkyPyzahn4J0iV0dE7kaz4Z/JYu1O33acwvLOM7ADNuSvthL25dgePgEntRESWmI4vTwk8E58YCbdkpfDSmA4rTT8Q642Dn/a2IOtTS5/KnVfhk3y/E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=f85blLN3; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id gpsns7sUcqvuogsQdsrdvs; Wed, 21 Aug 2024 20:59:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id gsQdsLSHnZlJQgsQdsEiJH; Wed, 21 Aug 2024 20:59:39 +0000
X-Authority-Analysis: v=2.4 cv=DMBE4DNb c=1 sm=1 tr=0 ts=66c6553b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=fyO6v0DDb0LEVeqNpEQA:9
 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZTzovHplSI3BP+uJC6iygv6C4FzmkK7w0ei9fXLVs+k=; b=f85blLN3rSmUSW0cGd2nkSarcg
	CDzQHMORYOlF9t00zjQESXKTw/a+ucbW98HD3VrsrL6gP0k6XF2mi+Cvf1a82UEacZqwx7BWieEme
	YyYaLv28e0xJc6gJi+sA18QaDFWAxdV0itvp8Rrz0TuBII9QASim9jqojT6wz7KQQDUmOK2KuAwA8
	j9eQAufFoDK9zLxYX/EgDr2Nzjj7CG41r5Bj/qMrp5jabOXqYg3JumVaVnrSOloiO/rEdVizWWyQ2
	+iuQ+f2YV8r/CDFUgm9NIurmrWyjaDYOj9qPTYTM+2KsyUI1u6rrBS49aFpMKezXnh93LHymW5l5E
	fxqBTAZA==;
Received: from [201.172.173.139] (port=38584 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sgsQa-001cxb-2e;
	Wed, 21 Aug 2024 15:59:36 -0500
Message-ID: <93b3f91a-baa4-48e1-b3eb-01f738fa8fc1@embeddedor.com>
Date: Wed, 21 Aug 2024 14:59:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: mwifiex: Replace one-element arrays with
 flexible-array members
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>,
 Ganapathi Bhat <ganapathi017@gmail.com>,
 Sharvari Harisangam <sharvari.harisangam@nxp.com>,
 Xinming Hu <huxinming820@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Y9xkECG3uTZ6T1dN@work> <ZsZNgfnEwOcPdCly@black.fi.intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZsZNgfnEwOcPdCly@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sgsQa-001cxb-2e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:38584
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKLoZOTyUeNcPgS/o43N++S2h9Icse/k0TMyUR9IFuOflX3p43rV6soC/z+HlRZi4rkgk5t0YJi2AqcpdL/6b++/udbzSWzu3OnNXIPqgwnqLAoPDYUf
 V4YiFGvfJtdZxW1dpp7N7VGdmIN/V3ATJn4vrSLSqa3wAcqJLwNSdnTxnsF7dX4gtWV2VFz2iNAHEZ2tyIISh/ZKnlU+ObA/qV4=



On 21/08/24 14:26, Andy Shevchenko wrote:
> On Thu, Feb 02, 2023 at 07:32:00PM -0600, Gustavo A. R. Silva wrote:
>> One-element arrays are deprecated, and we are replacing them with flexible
>> array members instead. So, replace one-element arrays with flexible-array
>> members in multiple structures.
>>
>> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
>> routines on memcpy() and help us make progress towards globally
>> enabling -fstrict-flex-arrays=3 [1].
>>
>> This results in no differences in binary output.
> 
> Sorry for blast from the past, but I have a question here.
> 
> This change seems converts many of the flexible arrays in this driver.
> But what's behind this one?
> 
> struct host_cmd_ds_802_11_scan_ext {
>          u32   reserved;
>          u8    tlv_buffer[1];
> } __packed;
> 
> 
> AFAIU this needs also some care. On the real machine I have got this
> 
> elo 16 17:51:58 surfacebook kernel: ------------[ cut here ]------------
> elo 16 17:51:58 surfacebook kernel: memcpy: detected field-spanning write (size 243) of single field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2239 (size 1)
> elo 16 17:51:58 surfacebook kernel: WARNING: CPU: 0 PID: 498 at drivers/net/wireless/marvell/mwifiex/scan.c:2239 mwifiex_cmd_802_11_scan_ext+0x83/0x90 [mwifiex]
> 
> which leads to
> 
>          memcpy(ext_scan->tlv_buffer, scan_cfg->tlv_buf, scan_cfg->tlv_buf_len);
> 
> but the code allocates 2k or more for the command buffer, so this seems
> quite enough for 243 bytes.
> 

I think this would do it:

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index e91def0afa14..d03129d5d24e 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1627,7 +1627,7 @@ struct host_cmd_ds_802_11_scan_rsp {

  struct host_cmd_ds_802_11_scan_ext {
         u32   reserved;
-       u8    tlv_buffer[1];
+       u8    tlv_buffer[];
  } __packed;

  struct mwifiex_ie_types_bss_mode {
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index e782d652cb93..f7153472e2a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2536,8 +2536,7 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
         ext_scan_resp = &resp->params.ext_scan;

         tlv = (void *)ext_scan_resp->tlv_buffer;
-       buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN
-                                             - 1);
+       buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN);

         while (buf_left >= sizeof(struct mwifiex_ie_types_header)) {
                 type = le16_to_cpu(tlv->type);

--
Gustavo



