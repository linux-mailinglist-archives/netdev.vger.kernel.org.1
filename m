Return-Path: <netdev+bounces-47584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDAA7EA89C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 03:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C350280F64
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1008F43;
	Tue, 14 Nov 2023 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DwiLRlYq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2D8C1A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 02:13:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19AD43
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zFVciWvHFeNA6SAP++9n0hbkEit1J1Ch+lTQq20Du54=; b=DwiLRlYqVg6eSlbS/cIA8I35F1
	8V6FvfRTMAdaXNs/ZV1mFYiZHKhOzJr3BxMfhytjRQ2eHN33Trk9dQbKn84IhlWIBEebZgyMiU8vf
	qH7lH8tCu4L+fy1w4vrARKkSXa9LB/KkGGjDcokmwU80KNCLCLeM3ekBWA5TCqCVJfdzh0fx9lE+z
	MGgzyUqrbcYUeOSGOH6tyDstOF5/Xa1XDqgR8rr2gFyYxVqUTocMUun+cI8MRiFnT5br8+IGNFtg1
	s6T863a5z/3i/UsAUfXM6qOrDHlWoPlFKDs0BXpq0vI6dpQz48SXRmH0KHUw+bmNJMgoA0I/L0Z+s
	MDKEoL/g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2ivA-000FrX-09; Tue, 14 Nov 2023 03:12:56 +0100
Received: from [194.230.158.57] (helo=localhost.localdomain)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2iv9-0002A8-GH; Tue, 14 Nov 2023 03:12:55 +0100
Subject: Re: [PATCH iproute2] ip, link: Add support for netkit
To: David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: razor@blackwall.org, martin.lau@kernel.org, netdev@vger.kernel.org
References: <20231113032323.14717-1-daniel@iogearbox.net>
 <20231113093429.434186eb@hermes.local>
 <f27315c4-c20c-48cc-9fee-7f00c853921e@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <04ab053f-87bb-bdde-4550-9aee41b65796@iogearbox.net>
Date: Tue, 14 Nov 2023 03:12:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f27315c4-c20c-48cc-9fee-7f00c853921e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)

On 11/13/23 11:38 PM, David Ahern wrote:
> On 11/13/23 10:34 AM, Stephen Hemminger wrote:
>> On Mon, 13 Nov 2023 04:23:23 +0100
>> Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>>> +	if (tb[IFLA_NETKIT_POLICY]) {
>>> +		__u32 policy = rta_getattr_u32(tb[IFLA_NETKIT_POLICY]);
>>> +		const char *policy_str =
>>> +			policy == NETKIT_PASS ? "forward" :
>>> +			policy == NETKIT_DROP ? "blackhole" : "unknown";
>>> +
>>
>> If you plan to add more modes in future, a table or helper would be good idea.
> 
> I would prefer a table driven approach through a helper than the
> multi-line logic here.

Sounds good, will include this in a v2.

Thanks,
Daniel

