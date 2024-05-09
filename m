Return-Path: <netdev+bounces-94813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E608C0C17
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB011F224C3
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB214830B;
	Thu,  9 May 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiUm/3BK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861B14884B
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240806; cv=none; b=ZqDIOe7R/urnq00ZkaOfiqokZtdE8/srl2qW0B25gHFG1NB73TcPdB+6FLJT1QrdRAr0pS3HFPBdcUjHIc9hBqT5AWCGuGnyh0+Fz+RcW+Uqip+Eobg/zdBNkhuYfHt3P6HOIyavAl/fHwPLYpNoRFG9Bwj2i58dD3oEtQjXHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240806; c=relaxed/simple;
	bh=HhgVgwFAw125HsYffBUcKULiQ/FHN6+J5MSrsuq4w2Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZiWx7BniLAKLBTbTm6kLMyTMniv0nxRDpyw+qeTV7wXvTHVxSKmTrkjX0KP0ccjom8cnzuAXXuM3lrIN5mzUI88wjKkBUlqVcieFvMSp03nw5i7kkrKxfxxnJEA/Arq1aRdiXmrlp5hQf9+wDvAKFVptlrAe022B2CgC67MxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiUm/3BK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715240803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6xdzoSLaBkieVNky7RVFLQHac2yeEC0n7m3n+rfK3Rc=;
	b=PiUm/3BKdF7d2IuF6/PIhi+ikFgTDCvM0xTu3n/j1gjRQhOZGtj9edlxz8GHMZSRPOd2iB
	mz1S19pC8FmL5cazkIuyztrW9XcWNyR79fz760z0EGKCIIU6aMA5p/lsgZpiGMmvxHJvBA
	NKHb3w8bX0DlAzyNBBZFWjeCvFeGoS8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Je0oWLAePneKq9UPVDFDyA-1; Thu, 09 May 2024 03:46:38 -0400
X-MC-Unique: Je0oWLAePneKq9UPVDFDyA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34db05be56dso80846f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 00:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240797; x=1715845597;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xdzoSLaBkieVNky7RVFLQHac2yeEC0n7m3n+rfK3Rc=;
        b=uYkY1OhbW4Yre6TVJ97h9RTpM58VFx7jg9oZ/DPm9eVfCpJoR2M/C69iddEuU3dgDw
         TZr6Y9XzIzA98psT2NFEXhCwJTXZKvQBDagg3ncE2XMh6mzHtGiAGLs2vf3dfVk4JAid
         HyOhI9uBCi4YuuOSoyargZuZPGVf1yy2uoXr8kFumJMGnkX2asFmPdtAM3zvn96LocXi
         y8w7cyNyxHSpUjIZcwFBTNvPUC3SP3Ag6MPj6jm2b7Tu7u6Lxwi0bkA7wLRcFZWZT8KL
         6T9cI747bov0wSrnaljqL/uAUWu81Z1voVO8VpoJtTydmMaXyeoDdhoGd4hhTUWnQMVW
         IQMw==
X-Forwarded-Encrypted: i=1; AJvYcCU6TFqYJPPpchv/KBLVnmsHERbe86WB4sYdOVirNnD/vpMh5v432JMUwh763TqWRsuHjH6zgmlcpaMlF8ZLavUGHcLYglaY
X-Gm-Message-State: AOJu0YzEiAAUbPSSGIltm7vSjtsjLnecY5gzU89Nnm/7Hnh+7VF75TL2
	hZ1xZmvMQev/UcTdFrpvTNV0MpkHXVYcaEY1BEqQUlTMCeHIeXDvBhIHNnqFwfgslxKdlDKs37H
	Dxu8n1j8juTy4hf8Iiqq1L5BUHF2RWcPyUzS3NeJn+aAanKiEV1cIPg==
X-Received: by 2002:a05:600c:1c0a:b0:418:9941:ca28 with SMTP id 5b1f17b1804b1-41f719d62b4mr34878325e9.2.1715240797647;
        Thu, 09 May 2024 00:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmSvzdCw9iXsAde+CQex6xKhWRl8ljB1dEZSk63p1UnNhtNjgqw+WKSP/6N6GSQe3WVMFozA==
X-Received: by 2002:a05:600c:1c0a:b0:418:9941:ca28 with SMTP id 5b1f17b1804b1-41f719d62b4mr34878105e9.2.1715240797172;
        Thu, 09 May 2024 00:46:37 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10:ff61:41fd:2ae4:da3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc082sm944823f8f.107.2024.05.09.00.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:46:36 -0700 (PDT)
Message-ID: <6891de8fbc542340d157634ff1fe6701443995a5.camel@redhat.com>
Subject: Re: [PATCH RFC net-next] net: cache the __dev_alloc_name()
From: Paolo Abeni <pabeni@redhat.com>
To: William Tu <witu@nvidia.com>, netdev@vger.kernel.org
Cc: jiri@nvidia.com, bodong@nvidia.com, kuba@kernel.org
Date: Thu, 09 May 2024 09:46:35 +0200
In-Reply-To: <103033d0-f6e2-49ee-a8e2-ba23c6e9a6a1@nvidia.com>
References: <20240506203207.1307971-1-witu@nvidia.com>
	 <03c25d8e994e4388cb8bfd726ba738eea3c4dcdf.camel@redhat.com>
	 <103033d0-f6e2-49ee-a8e2-ba23c6e9a6a1@nvidia.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 11:55 -0700, William Tu wrote:
>=20
> On 5/7/24 12:26 AM, Paolo Abeni wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > On Mon, 2024-05-06 at 20:32 +0000, William Tu wrote:
> > > When a system has around 1000 netdevs, adding the 1001st device becom=
es
> > > very slow. The devlink command to create an SF
> > >    $ devlink port add pci/0000:03:00.0 flavour pcisf \
> > >      pfnum 0 sfnum 1001
> > > takes around 5 seconds, and Linux perf and flamegraph show 19% of tim=
e
> > > spent on __dev_alloc_name() [1].
> > >=20
> > > The reason is that devlink first requests for next available "eth%d".
> > > And __dev_alloc_name will scan all existing netdev to match on "ethN"=
,
> > > set N to a 'inuse' bitmap, and find/return next available number,
> > > in our case eth0.
> > >=20
> > > And later on based on udev rule, we renamed it from eth0 to
> > > "en3f0pf0sf1001" and with altname below
> > >    14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
> > >        altname enp3s0f0npf0sf1001
> > >=20
> > > So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
> > > devices + 1k altnames, the __dev_alloc_name spends lots of time goint
> > > through all existing netdev and try to build the 'inuse' bitmap of
> > > pattern 'eth%d'. And the bitmap barely has any bit set, and it rescan=
es
> > > every time.
> > >=20
> > > I want to see if it makes sense to save/cache the result, or is there
> > > any way to not go through the 'eth%d' pattern search. The RFC patch
> > > adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It s=
aves
> > > pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
> > > scanning all existing netdevs.
> > An alternative heuristic that should be cheap and possibly reasonable
> > could be optimistically check for <name>0..<name><very small int>
> > availability, possibly restricting such attempt at scenarios where the
> > total number of hashed netdevice names is somewhat high.
> >=20
> > WDYT?
> >=20
> > Cheers,
> >=20
> > Paolo
> Hi Paolo,
>=20
> Thanks for your suggestion!
> I'm not clear with that idea.
>=20
> The current code has to do a full scan of all netdevs in a list, and the=
=20
> name list is not sorted / ordered. So to get to know, ex: eth0 .. eth10,=
=20
> we still need to do a full scan, find netdev with prefix "eth", and get=
=20
> net available bit 11 (10+1).
> And in another use case where users doesn't install UDEV rule to rename,=
=20
> the system can actually create eth998, eth999, eth1000....
>=20
> What if we create prefix map (maybe using xarray)
> idx=C2=A0=C2=A0 entry=3D(prefix, bitmap)
> --------------------
> 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth, 1111000000...
> 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 veth, 1000000...
> 2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can, 11100000...
> 3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firewire, 00000...
>=20
> but then we need to unset the bit when device is removed.
> William

Sorry for the late reply. I mean something alike the following
(completely untested!!!):
---
diff --git a/net/core/dev.c b/net/core/dev.c
index d2ce91a334c1..0d428825f88a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1109,6 +1109,12 @@ static int __dev_alloc_name(struct net *net, const c=
har *name, char *res)
 	if (!p || p[1] !=3D 'd' || strchr(p + 2, '%'))
 		return -EINVAL;
=20
+	for (i =3D 0; i < 4; ++i) {
+		snprintf(buf, IFNAMSIZ, name, i);
+		if (!__dev_get_by_name(net, buf))
+			goto found;
+	}
+
 	/* Use one page as a bit array of possible slots */
 	inuse =3D bitmap_zalloc(max_netdevices, GFP_ATOMIC);
 	if (!inuse)
@@ -1144,6 +1150,7 @@ static int __dev_alloc_name(struct net *net, const ch=
ar *name, char *res)
 	if (i =3D=3D max_netdevices)
 		return -ENFILE;
=20
+found:
 	/* 'res' and 'name' could overlap, use 'buf' as an intermediate buffer */
 	strscpy(buf, name, IFNAMSIZ);
 	snprintf(res, IFNAMSIZ, buf, i);

---
plus eventually some additional check to use such heuristic only if the
total number of devices	is significantly high. That would need some
additional book-keeping, not added here.

Cheers,

Paolo


