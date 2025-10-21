Return-Path: <netdev+bounces-231310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C907BF7463
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15AD544326
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E63396E6;
	Tue, 21 Oct 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jlx+j2bY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i0T9qZ8S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jaFzB+Hx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PPqXp3VF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3D242D7C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059399; cv=none; b=O/ZlKZLOI0QmNKG98DKvHLxDUkhPpZ8z+GbaDQjU9kIZxwZQ3X0lLP89cNRxNGoCjotxuwc30R7FtHWkzs3PBX9Z5ztUJ/NzfXL3wXAg8sm/5SRzZNFAqfIGmk5/XUgSSNLZ0/MRSO7NlA68n9Oup3LuTJBz+A//n+LnCH2oDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059399; c=relaxed/simple;
	bh=aaBf//MwHF1QdGiLOcYGU/AeLVE7O9HD39d7NKICQPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLElrswtqowLNxMebaUcl8SxAHXFvSy+GoAsli/2orDHW424MS7kifQmneqWw8oSCXe/euQkMfVVPsjWRi4xnd/BrqP8GomU/IqbV+KDYoJ10U+mgNRtls17H9eX4xUG7YP3pYH1m7l6UIpLUy26fc6vGskI/P6eR3lVk9Dpp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jlx+j2bY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i0T9qZ8S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jaFzB+Hx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PPqXp3VF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD22321187;
	Tue, 21 Oct 2025 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761059391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZe6DpPzcuTc/P40N0w5pkI5ZXDkLFg6fi8GxtLT6u8=;
	b=Jlx+j2bYgNptSPdD7NighHsh1KQicFxfzhBiuDowWi9lc4unRWOBQntKtxUIatuT0DhgNK
	h8AOj5RcV2V6SKcUgCC9nYXTPNVZDIAO5lQ0WeZ8m0OYbSfO0Sf4/ZDIjRpdKAIZO9LiwE
	3+1q7xsvMt5XO3SVrweHMLGXLpNuOuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761059391;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZe6DpPzcuTc/P40N0w5pkI5ZXDkLFg6fi8GxtLT6u8=;
	b=i0T9qZ8S6eEkXZr2QjEYSAoDYqtB8gbWn03Cjuwv2Eb3QbMP/vm+gZMdHr4zsOTqIPOkIv
	l/QmL34O+AyBvsCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jaFzB+Hx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PPqXp3VF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761059387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZe6DpPzcuTc/P40N0w5pkI5ZXDkLFg6fi8GxtLT6u8=;
	b=jaFzB+Hx1Xx3mYY79LzkU7+n9N9Nrbf/WC/65MN3LGLUMbO39aWqbSVtTSizKjcXmP2d9s
	xPHKFDshLlNuYntMjN+KHQJJW1ABKV2lrd0F26r9bC0WY5B4a42XfdUvKXarQC5Ybc1rw4
	tu27uTqI2r1eDotARIs6ptR9aXLrvHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761059387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZe6DpPzcuTc/P40N0w5pkI5ZXDkLFg6fi8GxtLT6u8=;
	b=PPqXp3VFTUbzYHqtIr69y/LhG4Gnu/OOWC3BThyxMbf/Jd+Kt9FSJfhwYk8J2/FYZcbAcB
	IBVglql9ogdvljBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DAA2139D2;
	Tue, 21 Oct 2025 15:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7RsPDDui92h2GAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 21 Oct 2025 15:09:47 +0000
Message-ID: <da50bdfc-99ae-4c3a-906b-5314192fe1f5@suse.de>
Date: Tue, 21 Oct 2025 17:09:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: null pointer dereference in interrupt after receiving an ip
 packet on veth from xsk from user space
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>
Cc: mc36 <csmate@nop.hu>, alekcejk@googlemail.com,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, 1118437@bugs.debian.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu>
 <CAL+tcoA5qDAcnZpmULsnD=X6aVP-ztRxPv5z1OSP-nvtNEk+-w@mail.gmail.com>
 <643fbe8f-ba76-49b4-9fb7-403535fd5638@nop.hu>
 <CAL+tcoDqgQbs20xV34RFWDoE5YPXS-ne3FBns2n9t4eggx8LAQ@mail.gmail.com>
 <d8808206-0951-4512-91cb-58839ba9b8c4@nop.hu>
 <CAL+tcoA0TKWQY4oP4jJ5BHmEnA+HzHRrgsnQL9vRpnaqb+_8Ag@mail.gmail.com>
 <aPedG99fdFBnbIqz@boxer>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aPedG99fdFBnbIqz@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CD22321187
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[nop.hu,googlemail.com,gmail.com,fomichev.me,intel.com,kernel.org,bugs.debian.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.01



On 10/21/25 4:47 PM, Maciej Fijalkowski wrote:
> On Tue, Oct 21, 2025 at 07:02:06PM +0800, Jason Xing wrote:
>> On Tue, Oct 21, 2025 at 5:31 AM mc36 <csmate@nop.hu> wrote:
>>>
>>> hi,
>>>
>>> On 10/20/25 11:04, Jason Xing wrote:
>>>>
>>>> I followed your steps you attached in your code:
>>>> ////// gcc xskInt.c -lxdp
>>>> ////// sudo ip link add veth1 type veth
>>>> ////// sudo ip link set veth0 up
>>>> ////// sudo ip link set veth1 up
>>>
>>> ip link set dev veth1 address 3a:10:5c:53:b3:5c
>>
>> Great, it indeed helps me reproduce the issue, so I managed to see the
>> exact same stack. Let me dig into it more deeply.
> 
> splat comes from skb_orphan() calling skb->destructor() with ::cb field
> being already taken by IP layer. A hotfix would simply be moving this call
> before we memset cb in ip_rcv_core():
> 
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 273578579a6b..db30645f8c35 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -535,14 +535,14 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
>          iph = ip_hdr(skb);
>          skb->transport_header = skb->network_header + iph->ihl*4;
> 
> -       /* Remove any debris in the socket control block */
> -       memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
> -       IPCB(skb)->iif = skb->skb_iif;
> -
>          /* Must drop socket now because of tproxy. */
>          if (!skb_sk_is_prefetched(skb))
>                  skb_orphan(skb);
> 
> +       /* Remove any debris in the socket control block */
> +       memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
> +       IPCB(skb)->iif = skb->skb_iif;
> +
>          return skb;
> 
>   csum_error:
> 
> However, I do not understand why setting mac addr on one veth interface
> triggers this path.
> 

Ugh, sorry then. I just sent a patch to the list and didn't see your 
email. Anyway, I believe it is safer to avoid using skb control block if 
other subsystems might take control over it.

Feel free to discard my patch at: 
https://lore.kernel.org/netdev/20251021150656.6704-1-fmancera@suse.de/

Thanks,
Fernando.

>>
>> Thanks,
>> Jason
> 


