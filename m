Return-Path: <netdev+bounces-214472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECBB29BE6
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 10:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EDA18A32F9
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A512FF66A;
	Mon, 18 Aug 2025 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b="JjCWV097"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC022F39D2
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505310; cv=none; b=ozlqHamZ+esTW/Vw8hacL9skz/d7pmf2Y4p6PvjCHI8rTye8ngMcNujmAKuPROUM7J+zT7e1CxiLwtZo4Bnl4y5peX42r5/i0/GxVOL1tYQ2lWqZ+SOMKEtlX0TZuUFrJ0oy1CZ/phaBXvb4Pxa1jI4EqDkLoFMQ7Hp4EpgdkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505310; c=relaxed/simple;
	bh=IC5yTS1+GELm3By1CHbJyAIU3wdNxNxaQGQ7ykHg1J0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XTTVGGinXDKtWTPa2NxdHlyhSKPRUw2O9S2yn4MSHZ1VMKwRn0ay+SqRJlkcHj/xi4IMh1W31PRnswlSS/5Kxn7v0Wor7famBZohx13n3y67tXC3WPZNFKE31DOSbWIIrBv5aLFDAUmGF6hqYWwFzlFfTIg2/XNe5X2aVkeZbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io; spf=none smtp.mailfrom=coresemi.io; dkim=pass (2048-bit key) header.d=coresemi-io.20230601.gappssmtp.com header.i=@coresemi-io.20230601.gappssmtp.com header.b=JjCWV097; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=coresemi.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24458317464so41375435ad.3
        for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coresemi-io.20230601.gappssmtp.com; s=20230601; t=1755505308; x=1756110108; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZKOijlZJzzyFkYu3fe0Wcg1XOYl5AWE1Ek2P30jLzw=;
        b=JjCWV097prrKKxla50Spd7+zwWv2eqXSUgwdpjTzs3Y1jNvFsRCbh3eCdK9Mjs3H/T
         lMUlMcFVFxWK78lbxDfLu/7xZSi7fi8OR9te7eAgB5TvZx0xkIBwD5IPXOzyNwCROZNM
         Z2V3vtk6YSYmhHONEwtsj6ApzntDVv2tn/M2H6byASVS0up7z8CjrZTYi+usbW/qXstl
         9dKCak0cg3Oh5e1xhJYj20cr57nLz66heYlUmBFd7BquhMD1jxDMvCIPgCVcQKXBwFsX
         0k+qpPLMqMSwaWHjSCqnVD2RJVvm8/38A7XoXMZk2q7mLDU/VrqxLi1aqufBYEwf2RPn
         d48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505308; x=1756110108;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZKOijlZJzzyFkYu3fe0Wcg1XOYl5AWE1Ek2P30jLzw=;
        b=dpvaNOQEhhbcW3IQi7ZaEFzP8Ch2KTWil0irfuSf9P21VwCtrQozMGq+7893qeT5AI
         LzIx/uc/udYhNOciep5w9CY0Ivs1dqy1JkiCjWIsqhdxi7pc7hh5RYGdo7blMkC6draD
         HTqMNohIZ/tJOl2QrtX53HOKmKJjVicCkREJMe0NoIzoyj9Cq7WQCpOuMoSWxPUREZpd
         59GSPU1PtdJQhzuWKycZuqqUXhwQNHeOLOKrlIzVZN3cmJNET/Lw9REKKzAxKN99r/z/
         zI6woSovrbUj3RiFMiE9nNXxVZjzK0gVVTHbCJC7gDqvD3OFaewQ7apmw3lMJtQtq5vy
         yYdA==
X-Forwarded-Encrypted: i=1; AJvYcCUZaP5ZF/TfP5uFCuktoMGSWICptXF6Lj87fI6CyUNpSSquwYyULx/pp3wYIwk35q00eBlYQhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPjPBxjK0UWHGafyJO4H5rgkrQ10sIqe7FYmoLwLbo/MKSCBo4
	L8GROzghwZ6Iu/iSJZfDud+XknKVU/msotImnmQl6ji8emMhWj6M55oBBPVYnjqNoHg=
X-Gm-Gg: ASbGncuXeZjYAi+is/LUVueW+pBlm7XqDgS25TBYbuspbazScxEzlHG5OmEgVKAdUu8
	gEv3J3RTESlSwrMIGSe8Ca3aEZpkPOf9ki8pwQN3MLIJ0z/T5x2nAvQq1P+aH8zRR//E+r8mqLC
	yQO2jIw+/zla/6/TbfBnpRYpw8nbH9OOVGaSwzPjCR2ezNkADl+xBe2QufCxbgyWVssWYxoRKo0
	h2Mu/QLxw9Ai2HCb6eTaydUAA8SkcePVdKhiL1zgXd6U+yr//9PjoiBJglTqIoyEvzBJikX5TZa
	BSK0J55P00WBtjE6H/mEcVFL0C7//QBkvi6AgWIMGoz5XAyys8s0zUn1QDEtj71wZqVsMGwc9Qr
	849jd9BV5IZlvHzR6oNjsGuWFxv7qD2pxRREqjgDeyHPe5st90THsQSE7JEt/7bC4Qw==
X-Google-Smtp-Source: AGHT+IGpHGiItAdWLhYKN0tytxZOCv9SOXo+fu+nWJwB3baZRk3wfV7mivIDYOKu1TTapldDZH5Nwg==
X-Received: by 2002:a17:903:11c4:b0:240:3f3d:fd37 with SMTP id d9443c01a7336-2446d87ff62mr136968385ad.27.1755505307843;
        Mon, 18 Aug 2025 01:21:47 -0700 (PDT)
Received: from smtpclient.apple (p121132.f.east.v6connect.net. [221.113.121.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446caaa804sm73467625ad.29.2025.08.18.01.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Aug 2025 01:21:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/3] dt-bindings: net: Add support for J-Core EMAC
From: "D. Jeff Dionne" <jeff@coresemi.io>
In-Reply-To: <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
Date: Mon, 18 Aug 2025 17:21:32 +0900
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Artur Rojek <contact@artur-rojek.eu>,
 Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <295AB115-C189-430E-B361-4A892D7528C9@coresemi.io>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-3-contact@artur-rojek.eu>
 <aa6bdc05-81b0-49a2-9d0d-8302fa66bf35@kernel.org>
 <cab483ef08e15d999f83e0fbabdc4fdf@artur-rojek.eu>
 <CAMuHMdVGv4UHoD0vbe3xrx8Q9thwrtEaKd6X+WaJgJHF_HXSaQ@mail.gmail.com>
 <26699eb1-26e8-4676-a7bc-623a1f770149@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)

On Aug 18, 2025, at 17:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> git grep jcore,emac
>=20
> Gives me zero?

Um, right.  It=E2=80=99s not upstream yet.  Thanks for your work to get =
that done, Artur.

>> If an incompatible version comes up, it should use a different
>> (versioned?) compatible value.
>=20
> Versions are allowed if they follow some documented and known vendor =
SoC versioning scheme. Is this the case here?
>=20
> This is some sort of SoC, right? So it should have actual SoC name?

No.  It=E2=80=99s a generic IP core for multiple SoCs, which do have =
names.

This is the correct naming scheme.  All compatible devices and SoCs =
match properly.
J.

> Best regards,
> Krzysztof


