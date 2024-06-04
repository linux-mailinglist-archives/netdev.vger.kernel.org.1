Return-Path: <netdev+bounces-100449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102F8FAAEA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7EA1F21545
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 06:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F932132135;
	Tue,  4 Jun 2024 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mHXpXP6G"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDDA801
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482869; cv=none; b=rGaHz+AOmDb1sTFK5GdJk0opKldedvdSRotGiZtnNdP3O7/dp4yOXQIk1qmfj4t+8mt++OPRMtx+2lhoDzFS+iSdNtKBsFgYVHTjDS/c+cqx8AL0By1QSg8/uTLTF5ddnKTgarbW7McRr7GxtVsf+zfBdX2K/uFcS8vPqCFYuSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482869; c=relaxed/simple;
	bh=l1x9O8lkXfY4/Q7yB+uFFc3dQR7pL2BbUfvnvuPWOKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpPOSw0nRQYcR04uCXHYwODQ4+spZLnUWq6CFBkU7Hi9EsPIATAXx5n8JFBHWI73eOhFTi8p9zOGUmz7zs5lya0wCAnZ7sBS8Yd0Tot373GMD2NUuQM23IJVfIKM3F7FdQcdiluaEe4Nr/oJla9PG9V6TKJtSdsUjhs9nG5y2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mHXpXP6G; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=uH/HKko7zCdPRDWgsmYgWG3psrtg6r8HMizNEJWDIQ4=;
	b=mHXpXP6GrYACZyJ8fJdPJiyppKInugKwFHiU9iTxgmSMAxTjolfPa2MCN58isR
	mLBE80ZK3GRqQMOEIytbbhK6w1l5Ow8LW4aMp409mcfvPbCXAXh9tuGkPGOvGeTW
	pSVZXnNZoB0glleG5naviiEz0gAPwq9gcGVWOpdJnA5oQ=
Received: from [172.22.5.12] (unknown [27.148.194.72])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wD3f9oktV5mOBN0DQ--.9032S2;
	Tue, 04 Jun 2024 14:33:09 +0800 (CST)
Message-ID: <7ae9a706-5d79-4f4d-963b-41bcdd8b7f7f@163.com>
Date: Tue, 4 Jun 2024 14:33:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] seg6: fix parameter passing when calling
 NF_HOOK() in End.DX4 and End.DX6 behaviors
To: Simon Horman <horms@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, contact@proelbtn.com,
 pablo@netfilter.org, David Ahern <dsahern@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <2a78f16a-0ff5-46bf-983b-9ab038f5a5cd@163.com>
 <20240603182116.GJ491852@kernel.org>
From: Jianguo Wu <wujianguo106@163.com>
In-Reply-To: <20240603182116.GJ491852@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3f9oktV5mOBN0DQ--.9032S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1xXr4Uur4DuFWxCF17Wrg_yoW5CF1kpF
	y5Ja4UZFs0qr15trWSvr4qyr17Wana9Fn8ur95Aryjva9Ivr1Ik3yxAr4Ykr17JrZxCFyj
	yasFqw12kwn8Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4SoAUUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNwrzkGXAliXbnwAAsM

Hi Simon,
  Thanks for your review, I will fix the commit log, and send v2 with your Reviewed-by tag.

On 2024/6/4 2:21, Simon Horman wrote:
> On Thu, May 30, 2024 at 03:43:38PM +0800, Jianguo Wu wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> input_action_end_dx4() and input_action_end_dx6() call NF_HOOK() for PREROUTING hook,
>> for PREROUTING hook, we should passing a valid indev, and a NULL outdev to NF_HOOK(),
>> otherwise may trigger a NULL pointer dereference, as below:
> 
> nit: The text above should be line-wrapped so that it is
>      no more than 75 columns wide.
> 
> Link: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> 
>>
>>     [74830.647293] BUG: kernel NULL pointer dereference, address: 0000000000000090
>>     [74830.655633] #PF: supervisor read access in kernel mode
>>     [74830.657888] #PF: error_code(0x0000) - not-present page
>>     [74830.659500] PGD 0 P4D 0
>>     [74830.660450] Oops: 0000 [#1] PREEMPT SMP PTI
>>     ...
>>     [74830.664953] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>>     [74830.666569] RIP: 0010:rpfilter_mt+0x44/0x15e [ipt_rpfilter]
>>     ...
>>     [74830.689725] Call Trace:
>>     [74830.690402]  <IRQ>
>>     [74830.690953]  ? show_trace_log_lvl+0x1c4/0x2df
>>     [74830.692020]  ? show_trace_log_lvl+0x1c4/0x2df
>>     [74830.693095]  ? ipt_do_table+0x286/0x710 [ip_tables]
>>     [74830.694275]  ? __die_body.cold+0x8/0xd
>>     [74830.695205]  ? page_fault_oops+0xac/0x140
>>     [74830.696244]  ? exc_page_fault+0x62/0x150
>>     [74830.697225]  ? asm_exc_page_fault+0x22/0x30
>>     [74830.698344]  ? rpfilter_mt+0x44/0x15e [ipt_rpfilter]
>>     [74830.699540]  ipt_do_table+0x286/0x710 [ip_tables]
>>     [74830.700758]  ? ip6_route_input+0x19d/0x240
>>     [74830.701752]  nf_hook_slow+0x3f/0xb0
>>     [74830.702678]  input_action_end_dx4+0x19b/0x1e0
>>     [74830.703735]  ? input_action_end_t+0xe0/0xe0
>>     [74830.704734]  seg6_local_input_core+0x2d/0x60
>>     [74830.705782]  lwtunnel_input+0x5b/0xb0
>>     [74830.706690]  __netif_receive_skb_one_core+0x63/0xa0
>>     [74830.707825]  process_backlog+0x99/0x140
>>     [74830.709538]  __napi_poll+0x2c/0x160
>>     [74830.710673]  net_rx_action+0x296/0x350
>>     [74830.711860]  __do_softirq+0xcb/0x2ac
>>     [74830.713049]  do_softirq+0x63/0x90
>>
>> input_action_end_dx4() passing a NULL indev to NF_HOOK(), and finally trigger a
>> NULL dereference in rpfilter_mt()->rpfilter_is_loopback():
>>     static bool
>>     rpfilter_is_loopback(const struct sk_buff *skb, const struct net_device *in)
>>     {
>>             // in is NULL
>>             return skb->pkt_type == PACKET_LOOPBACK || in->flags & IFF_LOOPBACK;
>>     }
>>
>> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> 
> nit: no blank line here.
> 
>>
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> I am slightly puzzled that this bug was in
> the tree for so long without being noticed.
> 
> But the above not withstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...



