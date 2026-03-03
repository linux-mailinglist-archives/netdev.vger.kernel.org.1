Return-Path: <netdev+bounces-263228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OImFZXtpmlKaQAAu9opvQ
	(envelope-from <netdev+bounces-263228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:17:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9B1F148C
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 603C83039DC4
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010103DEACC;
	Tue,  3 Mar 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gz4xdyry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9F3D3D04
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547445; cv=pass; b=hFONBIj89nmw7Q/2mmK8Zoeh4Cr+AdGGwPfoXy0fPzhLNGB7GP+1CBaIXPRvAlZHPysQR2y3WQa2W2bJbu4UEiq6h0l0bztKGR8Mavgbwiq/x7jRLYVmJY0opIRIIt/jnJLSk+u89sH1msM5PGPq+vmUbTDzgaDB3GtrU6KTo/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547445; c=relaxed/simple;
	bh=456Aas/ctBagsPWsuh7WK7mN7yduSU+MasWl7+0D7Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X78iN7/VSocEExQQ46MSZs6Csu5UUyBT+Vw7e3O4/HnT/Kk0XlDQ5LnuhcFjlMilVrYI1DOA6zuQa8oYugt2wfUN4dL3371OKp71FpWmMiakGbK3umKKU3vTmroiO6+WI6EXYeEhgppSWAV5NbCtomsVmz6n40egxdT4dV70vD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gz4xdyry; arc=pass smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-50697d6a69cso28614411cf.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547443; x=1773152243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9H1U4S3+XoeUMbYvvd8RDMbOYL5XNYpbevebZzMMrQE=;
        b=qPXnphYK/myF+zdcgQVjqsox4Syz9v01NJ780KzpuEc8qXs+7TKlShbLrY5bJljUfI
         +GECsjthVOQEPIL/XtUhNwTY411YAO326jPQpX8+ff9GZ6zvk9KXH0msg8OMOZ3BpSEG
         PnbvTaPqMace0J7D6UcJ95wvMpkU2Z40yIusyc8fLH+jrlKEUucEQVTfOeQ5evPMJ4Ls
         flyC3M6C/+sS8W4714e3FfhraPQrxfCMog8YwQOzHZCtTX0CdLGqPJpZwtx/9egvZKxm
         Bf2HfzwwRaM9mvu4cFTSNQ7kq7DLPJdnWRsWnWpP7LiBxonBOIvCCqZk8SA56TXzF27k
         y7eA==
X-Forwarded-Encrypted: i=2; AJvYcCW8dY70Z82Tx14k55TH3qroXIGbAHkb74I9P/H9VyRBHemRgFYzacgxxYn95/VBIlEAbmNHoBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOuTfov9QOgwA7S8nB5gLRiQ2zPDPLYnf8Pbl+OQ+m5YMkn0vz
	JMfr2cFBWH67t0O8kKoG8M+2q0P36iN809wPNkQ5p3HoDO+GPPr6cnzSO74KP+zKNuaQpyy5hp8
	gSkLmRLi7uy9nrPNDPEqvSuWywiooft1IMY6J6FtN1XRwvWFw7RBKbNMHVtw5dSA5mg4z9etEvs
	xUdYIh8VOgg01uFADqQTcy4qq8mssbfSSn/dPU95t51zlmKTJW8CbWfkzSwhWfKzKzOHrovs2RU
	mpxZlFtDes7tA==
X-Gm-Gg: ATEYQzzxh9JRp911d+zEYvLSYr0QGGFJs5XSEzYRzNxz2OqL5H5vs1jXqlV4Fb9/+UY
	OGj1BkQsUCvHlHOld0AZkFSuhjreuftr7jBG4G2hMFA9U4tx/bcwda9nuq8J0KSfTYHUT2B6jCW
	2gVzVLJv1oSqqJPqYq13nQQ5uLiQS9Tt6CQ7rHdtuZSay2isa33lDinZ4b1TdlMzwnZCpE1olgo
	zXun862TY3MFqUnFk/aNr2n/E4DY932ZvuED9p69UV0Gh0ruPNUccXeCOJM1ShYwakyG1JBahAM
	qXc/wKDJg/D5N3Yz78XQxjTx+A7zIcFwraxZb3SRFdNAv7EhVsqt1uMkpICKp9FbCec0qnrVw5y
	m9p6v3W2lQR69do/uUZVC3pIBNJZJ9aiOE9Etxj2PVL1UtTLeV1+REUBiT1oqYqidQqEInlbP2X
	bHDR0J0FrqpwXM6g12ghUwClygxIVU6r4o10tEl3G23BVCA9Xb9Sf2B6/FiYA=
X-Received: by 2002:a05:622a:204:b0:506:8738:6518 with SMTP id d75a77b69052e-507529da93bmr228169061cf.65.1772547442793;
        Tue, 03 Mar 2026 06:17:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744957ecbsm22954871cf.1.2026.03.03.06.17.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:17:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3870692eb93so54733611fa.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772547441; cv=none;
        d=google.com; s=arc-20240605;
        b=Np/nbmQXJULBkxXzDJeUDKYbukOjFbxQfcoR/l4AaWs0FEYslqhCIhYAYRkXOxQSt5
         aLLkk8xF6vyl3Low2VsfDdr3KItfczB8v+A7IsUeqmj/+H4n47JbgD36fkb5pfnotzBT
         C0HYK6TIa4qBcyEY85s8/Zc+ONZZpqLKfGceH931dIphY1zuIDcSU6muSmSF2MBBkChK
         fqth/aqO4QrZqwhCn1WTw4A7Y8R0QqzZmG+g1J51JStxJ5I6yGNYxuoAnd877ULIfq9J
         /3ZtoRt+e8XnzVfIZCp3RU+Ti4R6w41SxtrDNFqTAZ/5TSa2oTc7QmCrbk9VnyNxgPlR
         YJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9H1U4S3+XoeUMbYvvd8RDMbOYL5XNYpbevebZzMMrQE=;
        fh=pPPATuMim0m0dUUp8Sdw7HDn1hDu+VzxqBDA8iis0wQ=;
        b=AkbzfV+cKSoHL36JTRf25QrH2/29GXCTqJmvw+G12x31tpEDGSsEzb4sf3iCkcQ4ts
         xGQdJqpMV9gpIe9frOv1rO7BWLmAWjiDJ8June6LUIR5g1NLD6eD2tcN8W2Eqgn5k8e4
         2SiLWOs18aOoMJa+y6mlasLIrxX4W3JgSZokuNgicGolZLhELYeVozzue1Nddn+6se9P
         kTejNoswLMaqKH4fCrBlsAlmOvalOPdsGskrXUocWzeT3A/5KHkfllRnCAC3Fwsx+nWN
         YQWGXmP/OQCe7nFxbHSu/5z+3fROGUspquWWbwnmoYjG7lGN/5Gbu9mk6MUmpT0nCTLe
         toXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772547441; x=1773152241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9H1U4S3+XoeUMbYvvd8RDMbOYL5XNYpbevebZzMMrQE=;
        b=gz4xdyryxFw3Y4SfWqgVL+l66yCs1N4atcMCBRGHodKQyPh+jJreynMKBeU5aYEi0p
         UBF94ylMnzixeSf2lC03/JPdawVNxyh2ttn6R2JymYCYnHCv1+XsaJXhiIqmcni41xvD
         VpwIj5hYoIyBH7yLO8yoep5aKaE0TKoD25lH0=
X-Forwarded-Encrypted: i=1; AJvYcCWcHVOOurjZ1xICJWh8ahWLIM+FUXGhCPX1R082OkLszVy/ODbiwU2mCCtn2Ib3bDa0MaxKf44=@vger.kernel.org
X-Received: by 2002:a2e:9cd6:0:b0:389:fdb2:1068 with SMTP id 38308e7fff4ca-389ff357805mr91185261fa.34.1772547440765;
        Tue, 03 Mar 2026 06:17:20 -0800 (PST)
X-Received: by 2002:a2e:9cd6:0:b0:389:fdb2:1068 with SMTP id
 38308e7fff4ca-389ff357805mr91184971fa.34.1772547440157; Tue, 03 Mar 2026
 06:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302104138.77555-1-graf@amazon.com> <aaVrsXMmULivV4Se@sgarzare-redhat>
 <aaV80wWlpjEtYCQJ@sgarzare-redhat> <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
 <aaW2FgoaXIJEymyR@sgarzare-redhat> <27dcad4e-d658-4b6b-93b2-44c64fcbeb11@amazon.com>
 <aaaqLbRNmoRHNTkh@sgarzare-redhat>
In-Reply-To: <aaaqLbRNmoRHNTkh@sgarzare-redhat>
From: Bryan Tan <bryan-bt.tan@broadcom.com>
Date: Tue, 3 Mar 2026 14:17:07 +0000
X-Gm-Features: AaiRm52JEb6AVb0mzyIgBtpCH-MimPgZjYb76gWACsIcSJONxOy5WDbyUYProjc
Message-ID: <CAOuBmuaQwxKDJoirwtRwEP=690JcRX3Efk6z=udiOHsGr8u6ag@mail.gmail.com>
Subject: Re: [PATCH] vsock: Enable H2G override
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	eperezma@redhat.com, Jason Wang <jasowang@redhat.com>, mst@redhat.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, nh-open-source@amazon.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000095f3eb064c1f5cbe"
X-Rspamd-Queue-Id: E9F9B1F148C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263228-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan-bt.tan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

--00000000000095f3eb064c1f5cbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 9:49=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Mon, Mar 02, 2026 at 08:04:22PM +0100, Alexander Graf wrote:
> >
> >On 02.03.26 17:25, Stefano Garzarella wrote:
> >>On Mon, Mar 02, 2026 at 04:48:33PM +0100, Alexander Graf wrote:
> >>>
> >>>On 02.03.26 13:06, Stefano Garzarella wrote:
> >>>>CCing Bryan, Vishnu, and Broadcom list.
> >>>>
> >>>>On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
> >>>>>
> >>>>>Please target net-next tree for this new feature.
> >>>>>
> >>>>>On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
> >>>>>>Vsock maintains a single CID number space which can be used to
> >>>>>>communicate to the host (G2H) or to a child-VM (H2G). The
> >>>>>>current logic
> >>>>>>trivially assumes that G2H is only relevant for CID <=3D 2
> >>>>>>because these
> >>>>>>target the hypervisor.  However, in environments like Nitro
> >>>>>>Enclaves, an
> >>>>>>instance that hosts vhost_vsock powered VMs may still want
> >>>>>>to communicate
> >>>>>>to Enclaves that are reachable at higher CIDs through
> >>>>>>virtio-vsock-pci.
> >>>>>>
> >>>>>>That means that for CID > 2, we really want an overlay. By
> >>>>>>default, all
> >>>>>>CIDs are owned by the hypervisor. But if vhost registers a
> >>>>>>CID, it takes
> >>>>>>precedence.  Implement that logic. Vhost already knows which CIDs i=
t
> >>>>>>supports anyway.
> >>>>>>
> >>>>>>With this logic, I can run a Nitro Enclave as well as a
> >>>>>>nested VM with
> >>>>>>vhost-vsock support in parallel, with the parent instance able to
> >>>>>>communicate to both simultaneously.
> >>>>>
> >>>>>I honestly don't understand why VMADDR_FLAG_TO_HOST (added
> >>>>>specifically for Nitro IIRC) isn't enough for this scenario
> >>>>>and we have to add this change.  Can you elaborate a bit more
> >>>>>about the relationship between this change and
> >>>>>VMADDR_FLAG_TO_HOST we added?
> >>>
> >>>
> >>>The main problem I have with VMADDR_FLAG_TO_HOST for connect() is
> >>>that it punts the complexity to the user. Instead of a single CID
> >>>address space, you now effectively create 2 spaces: One for
> >>>TO_HOST (needs a flag) and one for TO_GUEST (no flag). But every
> >>>user space tool needs to learn about this flag. That may work for
> >>>super special-case applications. But propagating that all the way
> >>>into socat, iperf, etc etc? It's just creating friction.
> >>
> >>Okay, I would like to have this (or part of it) in the commit
> >>message to better explain why we want this change.
> >>
> >>>
> >>>IMHO the most natural experience is to have a single CID space,
> >>>potentially manually segmented by launching VMs of one kind within
> >>>a certain range.
> >>
> >>I see, but at this point, should the kernel set VMADDR_FLAG_TO_HOST
> >>in the remote address if that path is taken "automagically" ?
> >>
> >>So in that way the user space can have a way to understand if it's
> >>talking with a nested guest or a sibling guest.
> >>
> >>
> >>That said, I'm concerned about the scenario where an application
> >>does not even consider communicating with a sibling VM.
> >
> >
> >If that's really a realistic concern, then we should add a
> >VMADDR_FLAG_TO_GUEST that the application can set. Default behavior of
> >an application that provides no flags is "route to whatever you can
> >find": If vhost is loaded, it routes to vhost. If a vsock backend
>
> mmm, we have always documented this simple behavior:
> - CID =3D 2 talks to the host
> - CID >=3D 3 talks to the guest
>
> Now we are changing this by adding fallback. I don't think we should
> change the default behavior, but rather provide new ways to enable this
> new behavior.
>
> I find it strange that an application running on Linux 7.0 has a default
> behavior where using CID=3D42 always talks to a nested VM, but starting
> with Linux 7.1, it also starts talking to a sibling VM.
>
> >driver is loaded, it routes there. But the application has no say in
> >where it goes: It's purely a system configuration thing.
>
> This is true for complex things like IP, but for VSOCK we have always
> wanted to keep the default behavior very simple (as written above).
> Everything else must be explicitly enabled IMHO.
>
> >
> >
> >>Until now, it knew that by not setting that flag, it could only talk
> >>to nested VMs, so if there was no VM with that CID, the connection
> >>simply failed. Whereas from this patch onwards, if the device in the
> >>host supports sibling VMs and there is a VM with that CID, the
> >>application finds itself talking to a sibling VM instead of a nested
> >>one, without having any idea.
> >
> >
> >I'd say an application that attempts to talk to a CID that it does now
> >know whether it's vhost routed or not is running into "undefined"
> >territory. If you rmmod the vhost driver, it would also talk to the
> >hypervisor provided vsock.
>
> Oh, I missed that. And I also fixed that behaviour with commit
> 65b422d9b61b ("vsock: forward all packets to the host when no H2G is
> registered") after I implemented the multi-transport support.
>
> mmm, this could change my position ;-) (although, to be honest, I don't
> understand why it was like that in the first place, but that's how it is
> now).
>
> Please document also this in the new commit message, is a good point.
> Although when H2G is loaded, we behave differently. However, it is true
> that sysctl helps us standardize this behavior.
>
> I don't know whether to see it as a regression or not.
>
> >
> >
> >>Should we make this feature opt-in in some way, such as sockopt or
> >>sysctl? (I understand that there is the previous problem, but
> >>honestly, it seems like a significant change to the behavior of
> >>AF_VSOCK).
> >
> >
> >We can create a sysctl to enable behavior with default=3Don. But I'm
> >against making the cumbersome does-not-work-out-of-the-box experience
> >the default. Will include it in v2.
>
> The opposite point of view is that we would not want to have different
> default behavior between 7.0 and 7.1 when H2G is loaded.

From a VMCI perspective, we only allow communication from guest to
host CIDs 0 and 2. With has_remote_cid implemented for VMCI, we end
up attempting guest to guest communication. As mentioned this does
already happen if there isn't an H2G transport registered, so we
should be handling this anyways. But I'm not too fond of the change
in behaviour for when H2G is present, so in the very least I'd
prefer if has_remote_cid is not implemented for VMCI. Or perhaps
if there was a way for G2H transport to explicitly note that it
supports CIDs that are greater than 2?  With this, it would be
easier to see this patch as preserving the default behaviour for
some transports and fixing a bug for others.

--00000000000095f3eb064c1f5cbe
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
kKXUf8BmgVwrm4J21BIjpK/E9/meSALtIG7FIMpiIKpgHf1MRTzmYywQIWohaXxPRAEIYZK2DSMY
n+fDChhou4ePAtzo6/x8PTSWPrJbH05U1DQt9FRG7+xcvkNqnjJq+XZK0kiDDFD8BzIKO/cq3ziS
50EhbzFKXPpa46ztpJqQ+UJTJod2dB7SexAYJlBkjKlGc+niNQIDAQABo4IB2jCCAdYwDgYDVR0P
AQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgw
NqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDAk
BgNVHREEHTAbgRlicnlhbi1idC50YW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwME
MB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQWxgja/oUqPdrOSir6
U+YDJVND/DANBgkqhkiG9w0BAQsFAAOCAgEAIL+CGrIYdRkQ80Psq9FtFG65/EZQH8dFSXv3AJTk
220m3Q98q4NHh+AkBRw/pvzVQMJlRKEBKgM1qYw5FYYoC3IRpeqQ9NqnJHsEAHX2p7Hfkt3l8zd7
rT9DuQ4Tws1Fjxo4L7OcRz8NDD9f0Y+LHADvcMUHoex2PldpXkGuWd4K1eMjga8xPOrKKYYdvWYw
cX/rc+AYfo3B0OnjSWXjdsufMPVDDK23uGYfti1djyVhYG7hOCKjW3fg9QdDcVjVa4q7spoCPGnQ
HGghAH5+ZauOJU1r26oGjwR/73xvsig9pX887/zvEM5WdbTXK82mciLRR4iQB0UlV+8UxxpJzfGd
j/6onem1o3e1fTH0owcQEn59i7Ygo5cWJm0qnT7zPTS6pgkXJ4xmskj6Dcqi/hRkMlxovq3K05uN
+lgAFg6F7ugpiGTUcxngHsGMRlj8cXIhg8KZO0gBU5KthBSvioQgN2JpAyE5gUV7stnVCu8l+SAr
Oo+OqcCeAc14zE+TlRnoQVn/xF+q0zAyONDNmQO4uyl0EyLpTIYLK7wFxC6IDrz2FsEzlioH2cBJ
lUyNMZuhR7c1KUj3dr4qBG1506iDiJ5qqn2rBKJAvk0ph2Irlh+82seX1iL/wX+M+Wwkzoo34GGq
6CGv4ffBr8W+eQ2/QT4X10tgfAgSZ+Sag3gxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkw
FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlN
RSBDQSAyMDIzAgx+bIvtS2ArBR9RakkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIE
INJgsp+iimvuKp51tVU0hRENooY2OWONPcba116+vUOeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwMzE0MTcyMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHrmTB8YkIi6t3/PHsNJLtbXq3OA6CKDqUAK
WyUe1w+LlJIqMvavgnBzXWKYTixm9KrVZnKTf4n1qcQKwt4E3sRdMpKvRw/NQQ8nZIop4gGk21Je
o4xM4izjPuKZQYq50ywbDJ8B0Edc8+tQJNgxZrCq9R4G9YG/cweOpCqAi2IdRspqQkJgvAbt8yZu
JVRcGmuLdvkEZ5MRsHuDh0FDYhdHwGEY6ryh7wWUTzjJIHJZWwsk7WrNtBQvGI/OHEMbec3seMq9
AbJQfIVtlyZueyOD8d9Hu3eLOAZTcsG5hEhmfBX/zhSTrjw1E6yXr8ybBG4p2hLQSgSYZbJEpEdv
Y7I=
--00000000000095f3eb064c1f5cbe--

