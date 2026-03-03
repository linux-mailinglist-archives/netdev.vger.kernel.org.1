Return-Path: <netdev+bounces-263414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BSUOTZKp2n2gQAAu9opvQ
	(envelope-from <netdev+bounces-263414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:53:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E51F6FEC
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FFC930525C7
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D537CD52;
	Tue,  3 Mar 2026 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ywq1lF5l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUFl4vdF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D10C2C0296
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571188; cv=none; b=UgZ0zcCz843y67XiP7vgHZz+9ozeema0er6vBHEuZ2sDcA12CWG6i4Hiw+9m9l644GBzJZQnzgvax3oSuPJzZjUiG0tq3ZobfbmqD16ATRifOdLnWwkq9f3vXsrFUiuRfLBga87x5qsPu08xZx8PNAYCWOUhamScVR6xjvMFzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571188; c=relaxed/simple;
	bh=I5gpiqsO+dAgH/nEJUqEofkhf7ZFzhfOnIeWvdgbAYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVHN7OCQ/fSk4gUjZ0AyL3uaK9MZqOrRvJTBOJr/hUJHAXBxerNybt5u+nFG1R2/04JPqN4xJlXgKpO20Kkpi2gGh3iwcfVCEOhVWAycgvGfUyrNFbyq0Uw/nfUsRUWza3l5QqgmuEHRzqKvZfc5u4ibS9sMtuGk198PvPQsRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ywq1lF5l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUFl4vdF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772571186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VoJ2INzWG7kGdihTQvUQGIPL9oTDsZ5C8rJbFDor7iI=;
	b=Ywq1lF5ldlIuK3N8LLI6ioLMUChhiYtvz6Qr8CceNp50pVnKdhoncJBJAs6TyCtF0GiB83
	3rhLeoypFSsProbBky1srZJczWIW8THStD0sJb+9KwfI+K1g80CjcxQQgAipzl/ZE9KJX4
	ifRL36R9/jlOzdyXy0GRNwoidr30B/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-G4c6cTmYP3KQ4JOtu8DkFA-1; Tue, 03 Mar 2026 15:53:04 -0500
X-MC-Unique: G4c6cTmYP3KQ4JOtu8DkFA-1
X-Mimecast-MFC-AGG-ID: G4c6cTmYP3KQ4JOtu8DkFA_1772571183
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837246211bso74185415e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772571183; x=1773175983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VoJ2INzWG7kGdihTQvUQGIPL9oTDsZ5C8rJbFDor7iI=;
        b=jUFl4vdFmPneL1yOF7SRlvDZdmbwOGMPVmTFs5ij1O9kUrRqClHSsdno8CcnP2yVT7
         zxhibugFFpIATrwZ7K1eIDOiPmGaP1+kyKErixiqeGNVhf+Ast1PBhIvQ4RGNek1rsmp
         k3dfj6BZUVvJqmyUlo9Xx2PvU5v4m9azr5xSD81t+QzNPnULrikA1I+wj6qKaXbUR6v4
         NJqD/gG8ZIvSZObs05cdd9L5f3IBrOoGbFwcCUzYfuAthYEtK53lNTV7Siwnq3AkWqQp
         cn7LbWXBzun5VxzI0ATMX4XIVOQ+d1XI6JEYurTGVL0TlVkTDtjtPINVMmF4ztJ9DagX
         A+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772571183; x=1773175983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoJ2INzWG7kGdihTQvUQGIPL9oTDsZ5C8rJbFDor7iI=;
        b=YU6TWRlxD4cphRsS1+Oxr1dsiLRkGP4y/WKcIGMErjlDwxLiYt9/bTX30HtygNFpt6
         wM5nJ7ZJ/YAcdBVAaWXm7WWaqxKSuL3lXmuca04fCQTi5CyKAKchhbkQJf3WWnq19XHs
         7pJl2ZOiF2ijc1eldnvt+dJw0hc2AjzxjJ2UsbF43dmMd/8mfCm4q3baaPVxwNFL8OaA
         tDoNhBPwLQYTpiz84jaIRnV4ADxShvhOle+ej7f6B988FQeVkGyg/an9EV2cYCBHiPvv
         8HRG4I4ojiLmeBOUdEl5eZi0ZMTpxaKd65d+Xg04e2xJdIceMYk0Rzalhjp5lqeMkjXu
         mvTA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOlmUe6HSj42eacJ0k28PsXOZelC5MtYaTHanz9emoxOaZY/u7svel0BCUB6bYa9wQ5+yLNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEWyYB3o60XYYYOAxMlEx1Ma5ln0p90XjDfww1zcF69Qhs8+4
	NORP4wI8idMi132WwtOT/FCBmKjBEPIHkiaKSeLqwGp5KMAzurnzl/ksNxwfn0wdmFlyCcD+Hh3
	VgywflDAFPaT0XKxjMVbysmXzZnVMzQLYvkFqCbN7ih1CTMbzcm3uyVnljA==
X-Gm-Gg: ATEYQzzMNw58m+SmkhbitrzlBXhr+O3VwJN1q1RHGX+OHRQTYQeSIHhTXUz1/o6b9ZE
	O4UI0admP8aLgNQafOtwKr5piVVfLnLZlMLRvS8sW4pMDkVwSF6x49pF7xJc1UsxA/E4kQgOtXW
	izdu9WfzeVgTdIpr7mUayK0mCybGgUU3uCsrB6ifhTdTxKEiAs72TVlyTRyJzgzMb5YQoR06yuF
	CyJCfgRAoAlrpYQxQR3mbUBE6t3VJeF6n/AD4NT8NBOAJcIEVmcFVpil4sNSoA4OVk9l1bMgjpH
	9Bm6quZFaMK5CvuDH0m2vL1EYpLSxOViv3YMVTAEQ1jt2hq3q9vcLWns44UQiYLt6leak2S6YYq
	JDJcrkxuMlR2olgMSpj5io6KMB6d2EnvXtb7yW2rJnJ9fuQ==
X-Received: by 2002:a05:600c:4f8b:b0:483:498f:7953 with SMTP id 5b1f17b1804b1-483c9c21525mr326042855e9.28.1772571182895;
        Tue, 03 Mar 2026 12:53:02 -0800 (PST)
X-Received: by 2002:a05:600c:4f8b:b0:483:498f:7953 with SMTP id 5b1f17b1804b1-483c9c21525mr326042375e9.28.1772571182293;
        Tue, 03 Mar 2026 12:53:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188a20c4sm2138835e9.15.2026.03.03.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:53:01 -0800 (PST)
Date: Tue, 3 Mar 2026 15:52:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <20260303155040-mutt-send-email-mst@kernel.org>
References: <20260302104138.77555-1-graf@amazon.com>
 <aaVrsXMmULivV4Se@sgarzare-redhat>
 <aaV80wWlpjEtYCQJ@sgarzare-redhat>
 <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
 <aaW2FgoaXIJEymyR@sgarzare-redhat>
 <27dcad4e-d658-4b6b-93b2-44c64fcbeb11@amazon.com>
 <aaaqLbRNmoRHNTkh@sgarzare-redhat>
 <CAOuBmuaQwxKDJoirwtRwEP=690JcRX3Efk6z=udiOHsGr8u6ag@mail.gmail.com>
 <cc4093e8-31c8-4a14-80f9-034852cf54f7@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc4093e8-31c8-4a14-80f9-034852cf54f7@amazon.com>
X-Rspamd-Queue-Id: 693E51F6FEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 09:47:26PM +0100, Alexander Graf wrote:
> 
> On 03.03.26 15:17, Bryan Tan wrote:
> > On Tue, Mar 3, 2026 at 9:49 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > On Mon, Mar 02, 2026 at 08:04:22PM +0100, Alexander Graf wrote:
> > > > On 02.03.26 17:25, Stefano Garzarella wrote:
> > > > > On Mon, Mar 02, 2026 at 04:48:33PM +0100, Alexander Graf wrote:
> > > > > > On 02.03.26 13:06, Stefano Garzarella wrote:
> > > > > > > CCing Bryan, Vishnu, and Broadcom list.
> > > > > > > 
> > > > > > > On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
> > > > > > > > Please target net-next tree for this new feature.
> > > > > > > > 
> > > > > > > > On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
> > > > > > > > > Vsock maintains a single CID number space which can be used to
> > > > > > > > > communicate to the host (G2H) or to a child-VM (H2G). The
> > > > > > > > > current logic
> > > > > > > > > trivially assumes that G2H is only relevant for CID <= 2
> > > > > > > > > because these
> > > > > > > > > target the hypervisor.  However, in environments like Nitro
> > > > > > > > > Enclaves, an
> > > > > > > > > instance that hosts vhost_vsock powered VMs may still want
> > > > > > > > > to communicate
> > > > > > > > > to Enclaves that are reachable at higher CIDs through
> > > > > > > > > virtio-vsock-pci.
> > > > > > > > > 
> > > > > > > > > That means that for CID > 2, we really want an overlay. By
> > > > > > > > > default, all
> > > > > > > > > CIDs are owned by the hypervisor. But if vhost registers a
> > > > > > > > > CID, it takes
> > > > > > > > > precedence.  Implement that logic. Vhost already knows which CIDs it
> > > > > > > > > supports anyway.
> > > > > > > > > 
> > > > > > > > > With this logic, I can run a Nitro Enclave as well as a
> > > > > > > > > nested VM with
> > > > > > > > > vhost-vsock support in parallel, with the parent instance able to
> > > > > > > > > communicate to both simultaneously.
> > > > > > > > I honestly don't understand why VMADDR_FLAG_TO_HOST (added
> > > > > > > > specifically for Nitro IIRC) isn't enough for this scenario
> > > > > > > > and we have to add this change.  Can you elaborate a bit more
> > > > > > > > about the relationship between this change and
> > > > > > > > VMADDR_FLAG_TO_HOST we added?
> > > > > > 
> > > > > > The main problem I have with VMADDR_FLAG_TO_HOST for connect() is
> > > > > > that it punts the complexity to the user. Instead of a single CID
> > > > > > address space, you now effectively create 2 spaces: One for
> > > > > > TO_HOST (needs a flag) and one for TO_GUEST (no flag). But every
> > > > > > user space tool needs to learn about this flag. That may work for
> > > > > > super special-case applications. But propagating that all the way
> > > > > > into socat, iperf, etc etc? It's just creating friction.
> > > > > Okay, I would like to have this (or part of it) in the commit
> > > > > message to better explain why we want this change.
> > > > > 
> > > > > > IMHO the most natural experience is to have a single CID space,
> > > > > > potentially manually segmented by launching VMs of one kind within
> > > > > > a certain range.
> > > > > I see, but at this point, should the kernel set VMADDR_FLAG_TO_HOST
> > > > > in the remote address if that path is taken "automagically" ?
> > > > > 
> > > > > So in that way the user space can have a way to understand if it's
> > > > > talking with a nested guest or a sibling guest.
> > > > > 
> > > > > 
> > > > > That said, I'm concerned about the scenario where an application
> > > > > does not even consider communicating with a sibling VM.
> > > > 
> > > > If that's really a realistic concern, then we should add a
> > > > VMADDR_FLAG_TO_GUEST that the application can set. Default behavior of
> > > > an application that provides no flags is "route to whatever you can
> > > > find": If vhost is loaded, it routes to vhost. If a vsock backend
> > > mmm, we have always documented this simple behavior:
> > > - CID = 2 talks to the host
> > > - CID >= 3 talks to the guest
> > > 
> > > Now we are changing this by adding fallback. I don't think we should
> > > change the default behavior, but rather provide new ways to enable this
> > > new behavior.
> > > 
> > > I find it strange that an application running on Linux 7.0 has a default
> > > behavior where using CID=42 always talks to a nested VM, but starting
> > > with Linux 7.1, it also starts talking to a sibling VM.
> > > 
> > > > driver is loaded, it routes there. But the application has no say in
> > > > where it goes: It's purely a system configuration thing.
> > > This is true for complex things like IP, but for VSOCK we have always
> > > wanted to keep the default behavior very simple (as written above).
> > > Everything else must be explicitly enabled IMHO.
> > > 
> > > > 
> > > > > Until now, it knew that by not setting that flag, it could only talk
> > > > > to nested VMs, so if there was no VM with that CID, the connection
> > > > > simply failed. Whereas from this patch onwards, if the device in the
> > > > > host supports sibling VMs and there is a VM with that CID, the
> > > > > application finds itself talking to a sibling VM instead of a nested
> > > > > one, without having any idea.
> > > > 
> > > > I'd say an application that attempts to talk to a CID that it does now
> > > > know whether it's vhost routed or not is running into "undefined"
> > > > territory. If you rmmod the vhost driver, it would also talk to the
> > > > hypervisor provided vsock.
> > > Oh, I missed that. And I also fixed that behaviour with commit
> > > 65b422d9b61b ("vsock: forward all packets to the host when no H2G is
> > > registered") after I implemented the multi-transport support.
> > > 
> > > mmm, this could change my position ;-) (although, to be honest, I don't
> > > understand why it was like that in the first place, but that's how it is
> > > now).
> > > 
> > > Please document also this in the new commit message, is a good point.
> > > Although when H2G is loaded, we behave differently. However, it is true
> > > that sysctl helps us standardize this behavior.
> > > 
> > > I don't know whether to see it as a regression or not.
> > > 
> > > > 
> > > > > Should we make this feature opt-in in some way, such as sockopt or
> > > > > sysctl? (I understand that there is the previous problem, but
> > > > > honestly, it seems like a significant change to the behavior of
> > > > > AF_VSOCK).
> > > > 
> > > > We can create a sysctl to enable behavior with default=on. But I'm
> > > > against making the cumbersome does-not-work-out-of-the-box experience
> > > > the default. Will include it in v2.
> > > The opposite point of view is that we would not want to have different
> > > default behavior between 7.0 and 7.1 when H2G is loaded.
> >  From a VMCI perspective, we only allow communication from guest to
> > host CIDs 0 and 2. With has_remote_cid implemented for VMCI, we end
> > up attempting guest to guest communication. As mentioned this does
> > already happen if there isn't an H2G transport registered, so we
> > should be handling this anyways. But I'm not too fond of the change
> > in behaviour for when H2G is present, so in the very least I'd
> > prefer if has_remote_cid is not implemented for VMCI. Or perhaps
> > if there was a way for G2H transport to explicitly note that it
> > supports CIDs that are greater than 2?  With this, it would be
> > easier to see this patch as preserving the default behaviour for
> > some transports and fixing a bug for others.
> 
> 
> I understand what you want, but beware that it's actually a change in
> behavior. Today, whether Linux will send vsock connects to VMCI depends on
> whether the vhost kernel module is loaded: If it's loaded, you don't see the
> connect attempt. If it's not loaded, the connect will come through to VMCI.
> 
> I agree that it makes sense to limit VMCI to only ever see connects to <= 2
> consistently. But as I said above, it's actually a change in behavior.
> 
> 
> Alex
> 

I think it was unintentional, but if you really think people want a
special module that changes kernel's behaviour on load, we can certainly
do that. But any hack like this will not be namespace safe.


> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597


