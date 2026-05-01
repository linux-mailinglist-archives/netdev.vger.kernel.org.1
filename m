Return-Path: <netdev+bounces-283141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEUQIw5q9GkOBQIAu9opvQ
	(envelope-from <netdev+bounces-283141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 10:53:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AA4AB1E7
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0F7C30022BF
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392F933F385;
	Fri,  1 May 2026 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca4TDsdZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN+h8wlk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670C2E92D2
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625612; cv=none; b=gpmLcWIGYQUbg2UYgvDJsAymPGVoHFoEmTykQt9asBIJfK0mPSlwW3/oQTB1eM7WJqFKGINxMQC12r3PbakpKivhAud5JWnVfKmMFScm91Z+gEY80JIVDU5KS4KRQo17ZCLS3yR+qcWAiMSg/HG4EFv5bGjBTxXoRKF+vAb2ktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625612; c=relaxed/simple;
	bh=BTs2m/87ALc4fBMB2uRhrqVnoJYvXaM3RCCq6mV18rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEoQ2ctr3M8eW9Pqrh/cOuUxxk48+14cCsS6X3saU6Rj16U+vg1U1LmqkRRqxsTu7Cq1YfIV+F7CT/ZHIZTie0dRAz/P4MlpG8wAlgatlbfqmE9ThqvMTyMYzE32+khPRj1hBfL5KFzvxgB/IMoJsMTpDQQjtxRBuUkBMGD4Vm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca4TDsdZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN+h8wlk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777625609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pondFS8Aq/jVpna8I9ndw4ESa5Xh6101eut5D2XaHE=;
	b=ca4TDsdZylp0jp+Pz3hkY8gux9alB99WuUOH47odp3t6cK8niSGqTjKgc5MQjfHsxKO2vi
	+cd6wwEsXzDpfx1g51pJ5n+fyrzA6gOgbvneEScFFRyB2VigQgKX+ZBmzPjK5AZhyc8Roq
	2xWKxp7HLG/Ns3WuxeAq269XCQyMW10=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-roVU5fEQN6aMemyXMJII4g-1; Fri, 01 May 2026 04:53:28 -0400
X-MC-Unique: roVU5fEQN6aMemyXMJII4g-1
X-Mimecast-MFC-AGG-ID: roVU5fEQN6aMemyXMJII4g_1777625607
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b9399d68111so185526666b.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777625607; x=1778230407; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pondFS8Aq/jVpna8I9ndw4ESa5Xh6101eut5D2XaHE=;
        b=CN+h8wlkGJmICo+8cT1gAMrLkcInPkZ/a4JEq+FHw7Qmdic5kT3+WOSPZ05+LGY7Sb
         df8cfQ7Dk8O8FvtHHAKIJgbVFP7hGFn+nGe/oGCB7iB+6bmh5twVMgxOaajjktNiRMzS
         T/dbjmbxSXRlYCJ+ius6T/YCdVliRsnfJlW9bELfP91NWnaKMNx+OIVxuGGpFbqwtbxU
         T5I1hN71xjDLI8A+Mm3xbJBdgGT84bL0J05uGCFDQBK95hsUaWfjPqm8bKHWHb+WBBwb
         wTkpuimqOc6Kiyy9/O9EWJJHCi90AfXggS2X/MtQOBxCT/lKCOTHykl6TdcD/xfGzAN3
         rB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625607; x=1778230407;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pondFS8Aq/jVpna8I9ndw4ESa5Xh6101eut5D2XaHE=;
        b=DOgjiRm1xBxgsBfwEIAZS2Qa9FGlUTvhKtwJdkJCrjEh6GsLxMQlJFNf5+Vhp347oj
         geR2SSU+3WA7qhKsIjv78hF4XfkqeWi5BgO+GXHNw/Nttq6jitlxgkQgZj8+KoR3J2Wn
         KW1wjvUiQ9YdQsHW8MGZfrBCEEafCPhqCZ843bMTr7Nu6QDyjNh3CiTjDSHUfzpFT7Nl
         eBRjHskYnxvsMH8XQ1VEigq7A3VREjIs1SNT6AoY3Bqorwyo6gOFd59pJEYKSKO93V9x
         S9apQHVbHZ7By7RhitpOd+SKgjLZn2my5mUQmsbQYEnkOsL0mtfBRNK5G05W41u12EJe
         /96A==
X-Gm-Message-State: AOJu0YyXXF3lPtjLsYWgWCyuv9yjRsFvHYko0oDxOZvAfyfGIWfBrCG7
	vxlmpfkQS0z80EFN4CwUfC6UsYw/z1n9aBkXaRLSD7RckR/OO6wl9ACTfzwS4mn+NQvWKB4lwmf
	AzDdXJG9gwotx59+yfo/VZVROUyuEO83s1THWhJuoPRJw1lU7nyni+oZBvQ==
X-Gm-Gg: AeBDietUw3WTYd/kwoJXaUt9nOVsd0ylmOegoylnjp46ORIqHBsSitucPGLxOtvhv3/
	WT2mVxTpWT4Vd3iB3qCvxpFFXJ5oUYNpqfOqstUJnaDfvMSykVJZDtaPUEvPLpKgUHSiHNP7oD9
	MmrhcpBua/I3yR3sNbAjjVTuSI9OEcc7eVNsHT9tELyuNlffK6qL3S2NoIDNJFJn1gz+NWInFSY
	WboWhoooibxXfDM72fF795ZeVoBWxDvd+mTor88ZSsl+xaNyrSFimv0Ccbax5OZH5QwBmFPrHX3
	JayzwbwrdAD44R1U2fm9+c8cQtmm3qWgzhbHQOyJ7XHtm8FVSrO/1J/dzNf/dGfzfE29QlXGUDf
	IYOCLCWARq7YLhMYugDpYcEBlC18P/tBOSU8NcP3xEE5CUMMtpEwIhoRJ4M5biWXeMHqkwj56OL
	gMqdh9Zw==
X-Received: by 2002:a17:906:c14a:b0:ba9:2137:7165 with SMTP id a640c23a62f3a-bbac46d4b1fmr399323566b.1.1777625606873;
        Fri, 01 May 2026 01:53:26 -0700 (PDT)
X-Received: by 2002:a17:906:c14a:b0:ba9:2137:7165 with SMTP id a640c23a62f3a-bbac46d4b1fmr399320766b.1.1777625606330;
        Fri, 01 May 2026 01:53:26 -0700 (PDT)
Received: from [10.44.33.143] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b88472df8sm669104a12.28.2026.05.01.01.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2026 01:53:24 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Yuan Tan <tanyuan98@outlook.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yang Yang <n05ec@lzu.edu.cn>
Subject: Re: [PATCH net] openvswitch: vport: fix race between tunnel creation
 and linking
Date: Fri, 01 May 2026 10:53:23 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <17BF3316-75E2-46EA-A603-0F6B87FBD98F@redhat.com>
In-Reply-To: <20260430213349.407991-1-i.maximets@ovn.org>
References: <20260430213349.407991-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DF6AA4AB1E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283141-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,openvswitch.org,outlook.com,gmail.com,lzu.edu.cn];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,ovn.org:email]



On 30 Apr 2026, at 23:32, Ilya Maximets wrote:

> When a tunnel vport is created it first creates the tunnel device, e.g.,
> with geneve_dev_create_fb(), then it calls ovs_netdev_link() to take a
> reference and link it to the device that represents openvswitch datapath.
>
> The creation of the device is happening under RTNL, but then RTNL is
> released and re-acquired to find the device by name.  It is technically
> possible for the tunnel device to be re-named or deleted within that
> window while RTNL is not held, and some other device created in its
> place.  This will cause a non-tunnel device to be referenced in the
> vport and tunnel-specific functions used on it, e.g. vxlan_get_options()
> that directly casts the private netdev data into a struct vxlan_dev
> causing an invalid memory access:
>
>  BUG: KASAN: slab-use-after-free in vxlan_get_options+0x323/0x3a0
>   vxlan_get_options+0x323/0x3a0
>   ovs_vport_cmd_new+0x6e3/0xd30
>
> Fix that by taking a reference to the just created device before
> releasing RTNL.  This ensures that the device in the vport is always
> the one that was just created.  The search by name is only needed
> for a standard vport-netdev that links pre-existing devices, so that
> functionality and device type checks are moved to netdev_create().
>
> It is also awkward that ovs_netdev_link() takes ownership of the vport
> and destroys it on failure.  It doesn't know the type of the port it is
> dealing with, so we need to pass down the indicator that it's a tunnel,
> so the link can be properly deleted on failure.
>
> It's possible to refactor the logic to make the ovs_netdev_link() do
> only the linking part and let the callers perform a proper destruction,
> but it will be much more code for each legacy tunnel port type, so it
> is not worth it for the bug fix.
>
> Fixes: 614732eaa12d ("openvswitch: Use regular VXLAN net_device device")
> Reported-by: Yuan Tan <tanyuan98@outlook.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Reported-by: Yang Yang <n05ec@lzu.edu.cn>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks for working on this Ilya! The changes look good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


