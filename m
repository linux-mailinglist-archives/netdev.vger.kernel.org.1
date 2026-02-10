Return-Path: <netdev+bounces-258138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CQ8C0dri2lKUQAAu9opvQ
	(envelope-from <netdev+bounces-258138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:30:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F73511DF1F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE213052ADA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE82ED17B;
	Tue, 10 Feb 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NdqUEyUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD238A9A1
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744624; cv=none; b=jzq5ShGhItH1HwYdrDegW4EpREi8HVwNO/KyM/GcS4uk3/BT1p7kv8H1eirDmI2U9Dfp+UCbA43GjLitbY2fQriJGNwFxZ02+bo3LeA+Ykvx5QwamqUnGAcQ5T4qr1KKxEdmuZKYxnkVtDgyvO92h3C1AkeMZpx2f5TMMmmd28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744624; c=relaxed/simple;
	bh=h4SUjAC1/+1WI5l2vmSlYY/nKJfsmyvesTsuCN94dpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxd9+ih2GTSgn8KXME2dFN0Rt1VNLSMcwPYm0FuJGtk7GkDoEPCIjCe8zczIlOmeGg5xQ7+KDvSw6OGel21wNNk4nGmazuT5WBtrdjJeFA33Fp6tbXr92pQmXLc+GSS3ohDNMqvBbrRI2xxSrILv94Bzg/g738xQ1pTcyrNTfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=NdqUEyUi; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12721cd256bso2537234c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 09:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770744622; x=1771349422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uij+yze6+KWtPneIeRHK7BdEXls9H9TrWBaPlCemb3w=;
        b=NdqUEyUihUBWcyrk1wlON1+l0HMKekiKBUYUFH0+/Fr4pAiQMDmyEptnN8YXT0b948
         TS5/3osFxV6DakCjmOzK1x9qHqU79BR+ALthxqTcTOHMgN3EmV44P69seYit5RcOXc4z
         /LTH5+ppnNy0rnWLoziqsH9d+q3VnmbLjR533Dsq+c2bjWT3EY0BCzG9BLmQqe+b4LQ6
         TSeBWmMN6xOIilcGM4+/Ip2ftRrSvgrhfXFVcOTex2fZy/Kx2fdFV6YLCkUaqTyT4e33
         4lQ6Zs42v6HrZtqu9Qc1cz5zir2BhB0miB+F59JX5DmzcY94MBzPqCH13pSRmdMfBxX3
         /zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744622; x=1771349422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uij+yze6+KWtPneIeRHK7BdEXls9H9TrWBaPlCemb3w=;
        b=MedQJxOYagEKiXLcDnQ1prMOwB2JS+2P847vR00rCK7pLNIbzb4LP7AB7onXfCK6aL
         PuXEgz9VhoPHd6KjPNfFB617gVqcBalf2B6FW8/wvX17nrrqKHqwjRAooQIvoVER8GWy
         LBDi7h30G6pbWZ6FkeN0Fa0c7oGI7/ERJ3KXvxUIS3Rv+GvveirCdCZFmHtRyGVgI078
         7RuvmMJGeQrOjfOwufG7pzlcEA6FSbXDbk1KkxW/Ai7LwcfvORhBDBa+Oit1x3IpEhpv
         UCvHbg/lIDNqm7XII8UFbTjFkiTYU1F5yrK8w3QA+RVK3aHuyoSX/IPCT7vumU3QDFdL
         l14w==
X-Forwarded-Encrypted: i=1; AJvYcCUL3TUj1efsQ1TlPcOdBhGFZuig8d0lUbjyBPyxSxuoUUUNYLy6LTZ/jcVWdMb2208b4yjV3gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ERl/05F1o2ggsIfVqAHcEThZYGfJkao3OawqltezwSkELOoV
	L7y+c/tFytEUyjAn9I9uNt/b/5R4Kccg5Iq9/fpduyKJC+HgtCAEbx65LMx62XXigWU=
X-Gm-Gg: AZuq6aKl2iwTzOwe3pUCKfuIb30IVwQji4B+pDtcy/9XcWT7+wPRXWCmnXwxNlm0IDY
	0sUkv1sVis2mKF+q1UN4Z4MnbsISl62Wc2/XB+CNeSguDURIlsM4TCZCUREzGd2nqpSIdcXprAB
	HHSm1qkws8fa9r4mSkgPrLuQH+jOkQ7hRlPgA47BuhyHKZoxnlFgv06qiHYP1GhDCkhH+82/PbB
	zxPKLZGJtT+91kCECVYEsKdqT/k3k3lXUnZfy6txuFio3GluZCdAx68UUtFgNtvOQMiUOr+Bsno
	nKlt5k9Ra38MIgb4GcVKQOUmqDnQWtdAn1HCWv9Ty3GtEh4Mt97wCOep8gE3ZPj58QVVJ+m73DJ
	A5TcVhDiVZL5pnuVh6mUUefmE8xtBjah+1aP744BKMnYWqhJtafStvLd4IWyYhvfEqPXdh1ywoj
	7Ff65L1dhMFvgRcj/cJWPdowRIAbD3wGIJ68oQxJhEdYVC6aKU5+y3JEtMtWRdg5fUVP1wjNbfp
	XTKuLQVcHm00of6uvU1ogcS
X-Received: by 2002:a05:7022:1285:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-12703fe8c82mr6800135c88.37.1770744622066;
        Tue, 10 Feb 2026 09:30:22 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::1:a031])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9c91sm12989395c88.2.2026.02.10.09.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:30:20 -0800 (PST)
Message-ID: <82535cd8-7bcc-4454-b8ee-2af513bcf31c@davidwei.uk>
Date: Tue, 10 Feb 2026 09:30:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-16-daniel@iogearbox.net>
 <20260131163834.2c3d160d@kernel.org>
 <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
 <aYP7uiuPWAbJEgLD@devvm11784.nha0.facebook.com>
 <aYQBsTfF4PrJcHNl@devvm11784.nha0.facebook.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aYQBsTfF4PrJcHNl@devvm11784.nha0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,bytedance.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei-uk.20230601.gappssmtp.com:dkim,davidwei.uk:mid]
X-Rspamd-Queue-Id: 7F73511DF1F
X-Rspamd-Action: no action

On 2026-02-04 18:34, Bobby Eshleman wrote:
> On Wed, Feb 04, 2026 at 06:08:58PM -0800, Bobby Eshleman wrote:
>> On Mon, Feb 02, 2026 at 07:53:34AM +0900, David Wei wrote:
>>> On 2026-02-01 09:38, Jakub Kicinski wrote:
>>>> On Thu, 29 Jan 2026 23:28:29 +0100 Daniel Borkmann wrote:
>>>>> +class NetDrvContEnv(NetDrvEpEnv):
>>>>> +    """
>>>>> +    Class for an environment with a netkit pair setup for forwarding traffic
>>>>> +    between the physical interface and a network namespace.
>>>>
>>>> A little diagram would be pretty awesome to have here, and perhaps copy
>>>> it to the README file too?
>>>
>>> Sounds good, I'll add one. I forget how much you like ASCII diagrams.
>>>
>>>>
>>>>> +    """
>>>>> +
>>>>> +    def __init__(self, src_path, rxqueues=1, **kwargs):
>>>>> +        super().__init__(src_path, **kwargs)
>>>>> +
>>>>> +        self.require_ipver("6")
>>>>> +        local_prefix = self.env.get("LOCAL_PREFIX_V6")
>>>>> +        if not local_prefix:
>>>>> +            raise KsftSkipEx("LOCAL_PREFIX_V6 required")
>>>>> +
>>>>> +        local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
>>>>> +        self.ipv6_prefix = f"{local_prefix}::"
>>>>> +        self.nk_host_ipv6 = f"{local_prefix}::2:1"
>>>>> +        self.nk_guest_ipv6 = f"{local_prefix}::2:2"
>>>>> +
>>>>> +        self.netns = None
>>>>> +        self._nk_host_ifname = None
>>>>> +        self._nk_guest_ifname = None
>>>>> +        self._tc_attached = False
>>>>> +        self._bpf_prog_pref = None
>>>>> +        self._bpf_prog_id = None
>>>>> +        self._init_ns_attached = False
>>>>
>>>> I'm not a Python expert but the pre-init of variables that are set
>>>> later on in __init__() (on all possible paths) seems like a waste of LoC
>>>
>>> It's so that exceptions thrown -> __del__() don't complain about
>>> undefined vars.
>>>
>>>>
>>>>> +
>>>>> +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")
>>>>
>>>> Would we be able to do this with YNL?
>>>> no big deal but always nice to avoid the dependency on very latest CLI
>>>
>>> Hmm, I tried looking into this already. My understanding is that this
>>> can be done in C but not currently in YNL, not without adding a spec.
>>>
>>>>
>>>>> +        all_links = ip("-d link show", json=True)
>>>>> +        netkit_links = [link for link in all_links
>>>>> +                        if link.get('linkinfo', {}).get('info_kind') == 'netkit'
>>>>> +                        and 'UP' not in link.get('flags', [])]
>>>>
>>>> And of course if you use YNL you can actually ask Netlink to
>>>> echo back / return to you what interface it ended up creating.
>>>> No need for the scanning..
>>>>
>>>>> +        if len(netkit_links) != 2:
>>>>> +            raise KsftSkipEx("Failed to create netkit pair")
>>>>> +
>>>>> +        netkit_links.sort(key=lambda x: x['ifindex'])
>>>>> +        self._nk_host_ifname = netkit_links[1]['ifname']
>>>>> +        self._nk_guest_ifname = netkit_links[0]['ifname']
>>>>> +        self.nk_host_ifindex = netkit_links[1]['ifindex']
>>>>> +        self.nk_guest_ifindex = netkit_links[0]['ifindex']
>>>>> +
>>>>> +        self._setup_ns()
>>>>> +        self._attach_bpf()
>>>>
>>>>> +    def _setup_ns(self):
>>>>> +        self.netns = NetNS()
>>>>> +        cmd("ip netns attach init 1")
>>>>> +        self._init_ns_attached = True
>>>>> +        ip("netns set init 0", ns=self.netns)
>>>>
>>>> Hm, refactor class NetNSEnter or just use its enter method?
>>>
>>> I did consider this but I didn't feel like it fit the very specific
>>> purpose of NetNSEnter. I needed the init ns to have a valid nsid from
>>> within the test netns, which I didn't think many other tests would need.
>>>
>>>>
>>>>> +        ip(f"link set dev {self._nk_guest_ifname} netns {self.netns.name}")
>>>>> +        ip(f"link set dev {self._nk_host_ifname} up")
>>>>> +        ip(f"-6 addr add fe80::1/64 dev {self._nk_host_ifname} nodad")
>>>>> +        ip(f"-6 route add {self.nk_guest_ipv6}/128 via fe80::2 dev {self._nk_host_ifname}")
>>>>> +
>>>>> +        ip("link set lo up", ns=self.netns)
>>>>> +        ip(f"link set dev {self._nk_guest_ifname} up", ns=self.netns)
>>>>> +        ip(f"-6 addr add fe80::2/64 dev {self._nk_guest_ifname}", ns=self.netns)
>>>>> +        ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
>>>>> +        ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
>>>>> +
>>>>> +    def _attach_bpf(self):
>>>>> +        bpf_obj = self.test_dir / "nk_forward.bpf.o"
>>>>> +        if not bpf_obj.exists():
>>>>> +            raise KsftSkipEx("BPF prog not found")
>>>>> +
>>>>> +        cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj} sec tc/ingress direct-action")
>>>>> +        self._tc_attached = True
>>>>> +
>>>>> +        tc_info = cmd(f"tc filter show dev {self.ifname} ingress").stdout
>>>>
>>>> Don't we need to also add a qdisc if there isn't one already?
>>>
>>> Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
>>> know anything about qdisc, though.
>>
>> The ingress qdisc is the attachment point. I think we need
>> CONFIG_NET_SCH_INGRESS here too?
> 
> Sorry for the config stuff I'm replying about, I ran into needing these
> too for this:
> 
> CONFIG_NET_CLS_BPF=y
> CONFIG_BPF_SYSCALL=y

Thanks Bobby, I'll add these to the kconfig.

