Return-Path: <netdev+bounces-156451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E34A06775
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB6C16194A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 21:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C01A8411;
	Wed,  8 Jan 2025 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELhPhKYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9405185B6D
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372900; cv=none; b=aINJghUpTOqY6M9vthgaHLzHYPVmNFViXb6M21DlB+OV522Ipo4r7ywqQHdfJDQVZ4JuLxq9PivebR4gIgfoSsa7xGU6b55JCClIKKH9FMOy3ypZfjsQ4Dg5hlc4UdGUiXOiSTwjkfJdjREPDynbGFNoK4pex/iCwgfjq+7Wyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372900; c=relaxed/simple;
	bh=kLj1wtWGRYK7Hxvi+ZFnKxIoDhk/nlA54tNbKkCES5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oK+pI2W8rfOuC0H8aj17hQriiS1J53xTFeXcUx+dKBDVJ3XjwF2KMAu+A8gYCyJLW6SSF598El+9RHxFRHw+MVskIMh+LPXaI9MOLWEZ5LvMHnKuRRM0bXdn7kgEpHeKp3eUu49+y7wcf7rNZKPnq0tZEY4MrY0dbSioD2lTgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELhPhKYS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2efd81c7ca4so376848a91.2
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736372898; x=1736977698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLj1wtWGRYK7Hxvi+ZFnKxIoDhk/nlA54tNbKkCES5I=;
        b=ELhPhKYSrkhusMN4a9OZBvXtwka0AxApjk5sFjfuZe3p6lwDj9QEvKCIraU7O4bn1W
         kGzxX9vHxxqguvC/aPbYmIk+s9V4/OqqUA+/fXH6lXjOo7rr4nZl0q2GXfOy5yXpELVG
         N80PegNl7Z4Kak9w22WnBeW21ZDj+f5JJcfmnTSRcmoIBZkcS5MpsMweuVEcqWjNs2x8
         GcQVs2ih5wN43F5VuLY6+nxZh+oibbvCJA5C2ZezwESscBFL2m5Ik0G31ac5wcsDnWdU
         Notvwm9qV+h6XU/tnaM3sJHK+wj0tkXe2JFjxBqJen1sXonxkrPBK7EzvhkviUjgAJ/X
         1ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736372898; x=1736977698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLj1wtWGRYK7Hxvi+ZFnKxIoDhk/nlA54tNbKkCES5I=;
        b=TssIEI38N/CFDhKzLfSQTMWJu41T+77oyEjUgVRrLF0uv+IypdD5rtODC+qOIOalds
         RDr4QOab1kAsoL2FMXbnNMGrE41Q8ysWj8zhbZItpyegmpu2C4BcBr4QEK2zeyaURfr8
         QPn8vHzJP+29tRGSL5hZDF/6bpx4R/RfnjOScsP06r3am+g/hWa7PMSyKE4bQr5y4ZCu
         aS/G25CXYeLeUXRL5BMwg7CRltzyOvoEop24SEL3WUYSKfyNOkZCsUQsKVRYB2VgywoT
         nPuyCx44HKtRu07EMVOYgGJcvOOo6re0C07sHBEgB3F+39kNs8KrWA2lpldoARyR64tU
         DMAA==
X-Forwarded-Encrypted: i=1; AJvYcCXKGWEVJ0fU2/6r1moni7PHDvZtrEYtVldathBM6rLmfDI52cCwqfx1DtmEjumdWgAs7p/iHWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqO1R4mKBIU1Uq3IEGQwuMixccn3/hzzERPN1OP9j0OqO24nw+
	J2zoUZHqUnfF4DN+5Du2et3hhBgL68w0Br2HVcdDJu9uhJUWdv/h
X-Gm-Gg: ASbGncvtrNCWFnFrLKYkdkFXvVfukFZRv3c3ByqXVmzJuY8gwtF+i1XdGnDeG+nqkXo
	OQg2UCWZdQMD0zbDKUgAREu9u7WogleLAn6CDAoFb6CKRiEYoQpSkhASoNVzx6Qt6dzFa/51lay
	X1xQjNQD0ffj1FnxH/cwp9w4WenW4I7Meopsf3vOvMTxSWGYJu4CYTrruAEW0S0C0KlaCJrLvl/
	fXBLBI/X3yDjMLXSkemw2TXQZRbWnDMJwGKPi6VQSIvi196KpW9qcdAjfs=
X-Google-Smtp-Source: AGHT+IGHlVH+/sgTPsj2TP9LB3Gt8QvQkzOoKMni6JneeHBB8412Af3LZ7ZRosgij2Zj7KizxHzrsg==
X-Received: by 2002:a17:90b:5208:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f548eba9c4mr8103011a91.12.1736372898010;
        Wed, 08 Jan 2025 13:48:18 -0800 (PST)
Received: from [192.168.1.161] ([46.31.31.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96313esm331499685ad.20.2025.01.08.13.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 13:48:17 -0800 (PST)
Message-ID: <0ecf17dd64e3f492087fea9e9e5213424fc1ce53.camel@gmail.com>
Subject: Re: [PATCH net v2] Revert "net/ncsi: change from
 ndo_set_mac_address to dev_set_mac_address"
From: Ivan Mikhaylov <fr0st61te@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Potin Lai
	 <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
	sam@mendozajonas.com
Date: Thu, 09 Jan 2025 00:48:07 +0300
In-Reply-To: <Z37eu/758pzGSGzO@home.paul.comp>
References: <20250108192346.2646627-1-kuba@kernel.org>
	 <Z37eu/758pzGSGzO@home.paul.comp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-08 at 23:23 +0300, Paul Fertser wrote:
> Hello,
>=20
> On Wed, Jan 08, 2025 at 11:23:46AM -0800, Jakub Kicinski wrote:
> > Looks like we're not making any progress on this one, so let's
> > go with the revert for 6.13.
>=20
> But this does break userspace, the commit was there for a reason.
>=20
> Potin Lai, have you tried deferring this to a work queue instead of
> reverting to the code which has always been wrong?

Jakub, thanks for letting know about revert. ndo_set_mac_address do not
notify userspace about MAC change and as Paul stated it was always been
wrong here.

And we talked about reverts in this thread -
https://lore.kernel.org/all/20231210215356.4154-1-fr0st61te@gmail.com/

Probably, incremental proper fix would be better here?

Common case is 1 NCSI interface for server, we tested on this one and
works fine for us and that's the reason why we didn't catch that
situation. Nowadays some new servers has more than one NCSI interface.
Probably we missed that is softirq context which is obviously not a
place for rtnl_lock/unlock. Is there any other solution about except
delaying dev_set_mac_address in work queue? Or any suggestions about
how to deal with that in a proper way?

Don't have any hw with >2 NCSI interface, probably need help with
testing.

Potin, can you help with checking the fix?

Thanks.


