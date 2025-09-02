Return-Path: <netdev+bounces-218985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817D8B3F2AB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 05:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C494204A99
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EF62367D1;
	Tue,  2 Sep 2025 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHTG89jd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143D469D;
	Tue,  2 Sep 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756783858; cv=none; b=cjwaCxLI/MYtyHKN0qihsYZyIw+Gzayb4WG1/+khz/WqqZLJNfg7PJTyAatD8RepCtPfGNxSFzhlqs8KaQpra1RzMmPh1/0MkPt3I+NljzscdBrfm3mkliRP7UbFK/zkRdr1BTttx7lPoEwAEtFrmo4nxkrao1+v8z+7VmTwTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756783858; c=relaxed/simple;
	bh=ufFwImynso5Bq2CxyVZa1Z3HfWL7aJ9r/WzP9DNPFJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qie+NT0Trcae6ht54pG6O900FVFSQy/+thmm38qOvSkIrgR/dpo4Gbisp5MSqpjHgb+YQB3chJ+O0ZfaeRnCm7ESQr4LEPtTRLq2R2b+IOVoJjsaYg5jihzdK52zJFLNNxhMuc5h/m5bLLe/rADeStoYPRFx8feob2bzqP16GqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHTG89jd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b471737b347so3158929a12.1;
        Mon, 01 Sep 2025 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756783856; x=1757388656; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ufFwImynso5Bq2CxyVZa1Z3HfWL7aJ9r/WzP9DNPFJE=;
        b=KHTG89jdK+Rn5RoZzesuuPYjkPFu466KYYHO7pbvBkfc2Xad0MLfrYhwRyJj6Os/xY
         v55sqYcZ1uFZvVd9uFsMCAqcoJpH0C7FuobqHC1b0Dmpj15z2Ac0fJ9pcH4miNTIwQPf
         JGARXGKOAaGqs7maTyKjEzStEjg5FWPsxnBp2OqRmKQ6RIU9mw7Tc7hbhYOJ9byNGnpR
         0SAKO2kMRiyCmZcqnABBWqPkzH/Jhwa7TKNxu9dBapBQO88eTzVLL1hJFqHtsL0jglNN
         sIUdD5PTmLV6XlhnQIGrGK+wCc6ldTh09Xh1Iz8A0uj0KHPLSxB27I8V2QyOE1PEXEWX
         XZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756783856; x=1757388656;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufFwImynso5Bq2CxyVZa1Z3HfWL7aJ9r/WzP9DNPFJE=;
        b=XhxGjC1FfbLH/uP28zN5Ic7zMsuW0ILCu3/22PUcLalhq7qltK1ioq1H26ekLka4eW
         6IkvXXqKdYIaHQl7TlP7xFGcNmkiMMoPFX3CYZPrt2GbX2/d4gwgZqU94vR0+4yFJ/CR
         5HVq+4NmfPj/oSOQv4rrPIfrm5uS7QD7wv8XcbkOtRGwBEJlJKoO8NxvOYKK0vyi0qpm
         DIfQkYWinEX9C2plDkIGWJAxFphuapZhAVdD2c/0BdDApkxVqZUmDyXlrqusbRHuu6K5
         p+6NkRg5NH3ZZl6a4ZAKd4HWEG+pYtWjbhTZYLfpwQ8rs+QfLaNO5oehrWLscLzR9IHh
         MuBA==
X-Forwarded-Encrypted: i=1; AJvYcCWplMXRZh/auQ0sXpOLpH3N6tLIcNjSJ1CeQ9EUzrGp/QxfxL/KKPqLHJlG/8PhSg85TDZMbEr9@vger.kernel.org, AJvYcCXIArRtR2ISujVuhzCoatY8yIiUXt8x7J+4mZaGwpqHmqQOLmETtWkLXDoZj1PcoPtoPJOeOopUnSS8//4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83SgXKa2aubilgkH43ASx9h2Uk2GqLVD6MjV8Y+co15BFnLQp
	0+jeadIzZV3XRiOOLf2AOJ+2or5x4Ut+Zell1Z1AIT8K5dNNvkE3HGRQ
X-Gm-Gg: ASbGncuKH2yPfYbvvv0L/DRrznHhUi2RMOa4C6fBCoa0Zr4fWAwAX4v5RCAyJq7cdhr
	9nPemlBsajDNKkgHP8arBd+gMdsXj6WIxKqS7k6fh7Xgid65ShE0R+BI3hHLiuo1SNcaWbEGGz+
	VzlKNa3euKgS9Ak52CJjt3GiDZIcOrYaSbcZB8outL9LfUHMIRALB9dYNs6vdk0jT6vT03tkyzN
	4AaARTnJdsNbqvr9o1OjgqnGoHz9aMVvY7yPiz1rB4TfuJHH2pteGbm/rgJYU7QoSqw6TQ4EUuH
	OBOGm2OsTy6FmaR5BUWaGblboRY9AvJ8CTd0snz78Bh55f74OzJPb+syweMIXfj+cm9c58qIUg9
	dkHllEdy9xbOlrw/RtkefwQuAArD3kIon2QtrBq9SWKgdLBk=
X-Google-Smtp-Source: AGHT+IEWLqzRdh0yJn8Aksx0GkhFqYddmdc77+jsyaksy05k+WhwsrJquVPpepfa6EutwmpSr/yUHQ==
X-Received: by 2002:a17:903:120a:b0:248:d4d5:841f with SMTP id d9443c01a7336-24944b1f934mr111412905ad.58.1756783855828;
        Mon, 01 Sep 2025 20:30:55 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24a92f89758sm77842265ad.9.2025.09.01.20.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:30:55 -0700 (PDT)
Message-ID: <76d986e3f304dc199826228e90ad3f68160ba8f3.camel@gmail.com>
Subject: Re: [PATCH] net/tls: allow limiting maximum record size
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: chuck.lever@oracle.com, kernel-tls-handshake@lists.linux.dev, 
	donald.hunter@gmail.com, edumazet@google.com, horms@kernel.org,
 hare@kernel.org, 	john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, 	pabeni@redhat.com, Hannes Reinecke <hare@suse.de>
Date: Tue, 02 Sep 2025 13:30:49 +1000
In-Reply-To: <20250901113844.339aa80d@kernel.org>
References: <20250901053618.103198-2-wilfred.opensource@gmail.com>
	 <20250901113844.339aa80d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-01 at 11:39 -0700, Jakub Kicinski wrote:
> On Mon,=C2=A0 1 Sep 2025 15:36:19 +1000 Wilfred Mallawa wrote:
> > During a handshake, an endpoint may specify a maximum record size
> > limit.
> > Currently, the kernel defaults to TLS_MAX_PAYLOAD_SIZE (16KB) for
> > the
> > maximum record size. Meaning that, the outgoing records from the
> > kernel
> > can exceed a lower size negotiated during the handshake. In such a
> > case,
> > the TLS endpoint must send a fatal "record_overflow" alert [1], and
> > thus the record is discarded.
> >=20
> > Upcoming Western Digital NVMe-TCP hardware controllers implement
> > TLS
> > support. For these devices, supporting TLS record size negotiation
> > is
> > necessary because the maximum TLS record size supported by the
> > controller
> > is less than the default 16KB currently used by the kernel.
> >=20
> > This patch adds support for retrieving the negotiated record size
> > limit
> > during a handshake, and enforcing it at the TLS layer such that
> > outgoing
> > records are no larger than the size negotiated. This patch depends
> > on
> > the respective userspace support in tlshd [2] and GnuTLS [3].
>=20
> I don't get why you are putting this in the handshake handling code.
> Add a TLS setsockopt, why any TLS socket can use, whether the socket=20
> is opened by the kernel or user. GnuTLS can call it directly before=20
> it returns the socket to kernel ownership.
>=20
> I feel like I already commented to this effect. If you don't
> understand
> comments from the maintainers - ask for clarifications.

Hey Jakub,

I don't think I saw your email, apologies! But this makes sense, I have
drafted a V2 using setsockopt(). I will send it out soon. Thanks for
the feedback!

Regards,
Wilfred

