Return-Path: <netdev+bounces-241079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895DC7EBF7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 02:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C84E3425EC
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 01:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A872631;
	Mon, 24 Nov 2025 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRu6Q0MU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6698C8CE
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763948031; cv=none; b=SEq6PuVzmH3yhkdwaPQCNVKNSfte6Cj25Gt+uxJmn9F8cigpsnMCr7yoYUJKKVn19zDtXw2hFVjw/FN/KAYTxg1feju6WTAKHTWcNTgtasqC1LNuBRGy8AYvM+f04z4ISQkfCyW8q1m3UZpFvBzBKUa7AlnKlaBG23UsEZ747jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763948031; c=relaxed/simple;
	bh=5K3N+qLD569Jy/s6d4OCEOGGbKeC5whB9OMKRMgljN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVYZ1TTZfeOSyv+gaku91v9Fp7Af4vt7Xb9yvy/Du6NL7fIf/cqdJyFzjVlLwVwPBu95r/mzMCsPsf5SdVyLz15ChAP7HYtgaGth7biIxWUStNNOd+S6ZtnM+eCv0C6cGAHQ+RzLljL4QD4NCyk9gDLooFsS3zC8vR0ODJEXzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRu6Q0MU; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbddd71c46so1514758137.2
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 17:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763948028; x=1764552828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN+gqjrmJZG5LtP0SEyScR2TDuYDbSmg3gkIbqkEec4=;
        b=gRu6Q0MUrbyLvkravb4aXHNtiDGA/0i3NuiiGml1d8RfliKXnSI9RqyBt0oI6WkWeZ
         WQELVgpyulSZfH4teN0jPEj53m6lcvV5tSXu5fQqw6G78qT1ug0CzRyb5npVB5Sh3oV3
         pF5rIBCPOb/HKzF1UlFZUlC9ETvDC8i91HXwjXndS9T1J/Ac2/SFANZijKrg4VrtB8dH
         mQiTxxUHtnFIYiBEgin0UlAnm6Z5crJqkZVIN3W6OJ2kOUg8RC87PMicWb2SLTIxqW88
         ZOypWGQILcrEdAd46Zb6cBgPZ2JBAack5K1PPREgm7DJPkCPepoDyCGLJANeUuXYBdzq
         uMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763948028; x=1764552828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pN+gqjrmJZG5LtP0SEyScR2TDuYDbSmg3gkIbqkEec4=;
        b=q8jmT0tqkOUfgGxI9KlgTvPxoJ9RNBDncOPGNHMXyKHwH2nwrDxpIL+wITzZ2brty3
         ON5nXfJIgBfPQ9ItwLgJnMbkBnFKMhzaJWx1PUGlHmCb2mTDYKYb9ZwMYK0O+62cUdRU
         N+oFx5KrFPpMeAlyAjCJPURQlde5bfSuXOOvQ2ZAvvJZ+hokk8mrLNHmZg8OZsSZJyot
         IdLmIruCYsiD580Q0xJncapTnb80BabsEFIrFI+1KRSsTu+AdUeVEpETa8uzdHVSUjiZ
         ORGrrO19msHx7x6Z2aveLJbreSE81YZrY4r4NQ2AohGJAYzX8DWb1CNfrBLpSNn35EK2
         l02Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdwTH7Zl6CqZ49nK415rVeBOl4QCAaQ3Og/cpP7S158cexGE5fX5OOYuPCxGdbfrrQUmbAjQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaJ4p77JxW1XY+lyLsfAfKZFDnTm8I98e1qF9D0QWx121mx2K
	xLheRq0e3LO+ABpSE8xOVrTpFKQNk/DVXBpM6GijxNz6lNz917KyfczrDivJPmEGts/VynM+lw6
	IIVhj5VjQWkeJWPec4Ix4rexeQ0TxGsYpn/yZ
X-Gm-Gg: ASbGncuCMB13DJZsZk4lUq+MoplkaEfh1Re94M47/dtbtbqsdho6E2Hy1vaEsiFkm9W
	GV1Ua/R7kMcs2I9ChGH+jD2gfG9y2DEJe8A6cKHnKeMyrumYoKMszo/JvkrLSwO2E478KgCtG3W
	pVvL6N1Z0VhX+Dy64rrbci7X/Xyv3OSMJQbQV8Bg5kpi+nNBm6siZCsu5qO9bzfk+Seq4uO9yTu
	/5sc57JVO8DuwVgiH73WH8s98dZPeaOMT9Iw2hOBy4u91bQZzJke4pyctFTgLqUqVfysORKoY1V
	FfiN86067Y95OfLWm2LwYMVO/q8/ZUlrvzwOrlI=
X-Google-Smtp-Source: AGHT+IFmJxbuNCnLx1K9AUN6sEjak9hqaW6Sjo0QbxTkjD/P/WLZeJgxpulT3LdUe/NvhObr1zkEl5JEiq3EqE4u6II=
X-Received: by 2002:a05:6102:5a8d:b0:5db:e851:938e with SMTP id
 ada2fe7eead31-5e1de1ed4b6mr2578129137.10.1763948027866; Sun, 23 Nov 2025
 17:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-220774-17063@https.bugzilla.kernel.org/> <bug-220774-17063-qOQ3KbbRZE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220774-17063-qOQ3KbbRZE@https.bugzilla.kernel.org/>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 23 Nov 2025 17:33:36 -0800
X-Gm-Features: AWmQ_bl2XiEpQlLnHDVMpXJZM024jY5mbxLbPO5rnbUb5vCDpgvgYmU-FPHVdAM
Message-ID: <CAM_iQpW7WE17Xad_YVsOpz5_+uJzB2_7zOPQE3xOoT-nt4UAXQ@mail.gmail.com>
Subject: Fwd: [Bug 220774] netem is broken in 6.18
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Fri, Nov 21, 2025 at 3:39=E2=80=AFPM
Subject: [Bug 220774] netem is broken in 6.18
To: <xiyou.wangcong@gmail.com>


https://bugzilla.kernel.org/show_bug.cgi?id=3D220774

Gerlinde (lrGerlinde@mailfence.com) changed:

           What    |Removed                     |Added
---------------------------------------------------------------------------=
-
                 CC|                            |lrGerlinde@mailfence.com

--- Comment #2 from Gerlinde (lrGerlinde@mailfence.com) ---
You know, in our HA and ECMP setup we sometimes get this strange thing: pac=
kets
are not lost, but some flows get duplicated for a few hundert milliseconds.=
 Not
all flows, only the unlucky ones that get hashed through the broken path. A=
nd
this makes debugging really a pain, because all metrics say =E2=80=9Cno los=
s=E2=80=9D, but the
application still behave stupid.

So we use netem duplicate on a single mq-queue to copy exactly this situati=
on.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.

