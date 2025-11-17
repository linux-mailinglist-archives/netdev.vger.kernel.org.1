Return-Path: <netdev+bounces-239263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA36C66876
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78C8D3540D3
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222212472BA;
	Mon, 17 Nov 2025 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDz5FARY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852161E1E12
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421014; cv=none; b=bDzr3/4NhoW6TH/U2XRzJgDQSwEUq+0VZ1hjcDTSeQb6dgWg70upzFXBGzz8jlBJu8tMCaIWqDU7LNWQ0XXoZQUe9mkuwvJ/5AfS5Fws3s2aBUO10/ceqkN2cNmUy4IkgxMK6TbiF/K+OxPnqPk5e2bFrDlmT3HgwV+sC+FQvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421014; c=relaxed/simple;
	bh=I9zAGJAkw8L1DcoV9q7X9fkcY36N75bautc2NRk+3yE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ebcy//txPmfZmDRe9aaWjU2ATR0N0QpNSkE0wAtwuf8ei/naQbTuOheyB/n3Oa6IZbUom7smD4aZhGII911KBGQIM6DZOQv+kGfvbVu2ANAFp963tTaxzH4Q63yA0OHjM4uh+SOatn0E3OHdTNg+QDA9OA5uEAaNbQiAhzMS+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDz5FARY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297f2c718a8so7711095ad.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 15:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763421012; x=1764025812; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbkSGM7gQRkoSMINrNSNBNyEUg9Dwz0J0VGQNJ9Lfak=;
        b=UDz5FARY85oFERJOa3yMtvwZUJtW+57TVdZG/sj/duuKJjbhIKIBgEZf8YT2UuKj5h
         E1Jm/mgo/bLpReQlylHGcIB6x1VMyy2/R5CsLH/eoelrVF1OwmnGUoJQL3jHvBnPyldz
         ZXi9I120s2cSU4CMm0m5LJW3n6C6W0nAlJq6rAZXZ+Lp5K34RlMagVssdU1gEA2dq1xn
         v2LapCfs3mV4AJGjqPeuIJtzc5iIJvSPBfcSs/Vt+/R0mSWGz23AL/6TuQhoRssf/k97
         cT4E3aams6IwC6iJRQ1e00oXt4cY++JUW8RwIrtHwVMsHe45V7G2PkfhfQ7GfYnvRdlB
         lojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763421012; x=1764025812;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbkSGM7gQRkoSMINrNSNBNyEUg9Dwz0J0VGQNJ9Lfak=;
        b=SUH11YBjj/CztodrplTauwGqquM7wv6fpGVaQdx50sYIJz6o4BEr1D9Gwltbzge+Ra
         bpWHk3tVrC99Bag+5HpwE3rTg4G6u2Hn2UCyxhkbETQXwhF5P1JefaSKZ8CkxacbSu10
         x6eU7celmlESvGT2QEzQQWZmfT8sB2d+/jclSgCRG6CyKcE/M93IsM8SGiKa9cKwBbe/
         /M0ScNm6te1J7SjtrgjRkiyk1OMBrM3ABc7xmL1cD1ccfHL3LAmZ31V/L9JmiDB6MGBh
         b/5qAux/2tt4CdfDr44PJfU4g/1T1DM3/JgXMrxiDY74p7LE2wS6rZab9fP3FP0fWwpZ
         f4AA==
X-Forwarded-Encrypted: i=1; AJvYcCUOqCgzIXVhBQlyYn6/atcx8FCYVSBGV31th1SfFrmVrD/UTA3vaSZjB92DP5jwKAGEFF4zOZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAh8Uo7fS0bjJ57pdwgrHvsGcprYNsYOWg75ZAGOQeq8yDyVa
	sWbgJF3XWDFx2WOgQB5N2wsR0ynKF6KrMLDOWamQkdQSW9S2ZS4Sv4oH
X-Gm-Gg: ASbGncsH2VNsczQ5Vr32hR2/fNd5iSxjt/1rZ1lonaXJs38+kA+15Zy4m6lCk1R+B8c
	kFHQHfky0Xo6vjp70qfF9i7ByqM85eJo9y7fHCZ9hpKsgWvHZXSqi3Dp+NU+0UhAbjohnG+RDTj
	bfPaI/Ksl033dgAY/qS8+fhgI/42rxJIxMKiX1IlfKfKLqcIg5Qq1fBpw1knN+SCw/sTMURBC8R
	7f8nr9YZ/M2BHv+nnAFp5xkmtr3fywFAyacFz/3hIMJWt5v5yhkEAea8Piw95S7ExUBM7rm5WLT
	vSJFrRenoprBLsUai4Yfw7pndGU9z0f+LZPpjT8MdsAh1URqNehuPZi0NF9UdDdD6jrRBFjTzKw
	h1MXy9AfpAos4FiwaeHCZbzWh5onM31slstGgDcIQfr/jbzNZFAP3vzRTpcuTz10wU1iFURFsu6
	S44C3RBZ2R97ybpacukhDDESgGlMXIeFm2
X-Google-Smtp-Source: AGHT+IFfzMus+3nSr80tm7pag+JEK8DbD6fPURI/vooc88yL1Zi1PL8AWz76CHHxBWKDmMhSa2IlWw==
X-Received: by 2002:a17:902:cec1:b0:296:549c:a1e with SMTP id d9443c01a7336-299f65432f1mr4845185ad.3.1763421011688;
        Mon, 17 Nov 2025 15:10:11 -0800 (PST)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2c0577sm152403775ad.78.2025.11.17.15.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 15:10:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 net 2/2] selftest: af_unix: Add test for SO_PEEK_OFF.
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <20251117174740.3684604-3-kuniyu@google.com>
Date: Tue, 18 Nov 2025 07:09:56 +0800
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@bytheb.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B657CC7-B5CA-46D2-8A4B-8AB5FB83C6DA@gmail.com>
References: <20251117174740.3684604-1-kuniyu@google.com>
 <20251117174740.3684604-3-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: Apple Mail (2.3826.700.81)


> 2025=E5=B9=B411=E6=9C=8818=E6=97=A5 01:47=EF=BC=8CKuniyuki Iwashima =
<kuniyu@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> The test covers various cases to verify SO_PEEK_OFF behaviour
> for all AF_UNIX socket types.
>=20
> two_chunks_blocking and two_chunks_overlap_blocking reproduce
> the issue mentioned in the previous patch.
>=20
> Without the patch, the two tests fail:
>=20
>  #  RUN           so_peek_off.stream.two_chunks_blocking ...
>  # so_peek_off.c:121:two_chunks_blocking:Expected 'bbbb' =3D=3D =
'aaaabbbb'.
>  # two_chunks_blocking: Test terminated by assertion
>  #          FAIL  so_peek_off.stream.two_chunks_blocking
>  not ok 3 so_peek_off.stream.two_chunks_blocking
>=20
>  #  RUN           so_peek_off.stream.two_chunks_overlap_blocking ...
>  # so_peek_off.c:159:two_chunks_overlap_blocking:Expected 'bbbb' =3D=3D =
'aaaabbbb'.
>  # two_chunks_overlap_blocking: Test terminated by assertion
>  #          FAIL  so_peek_off.stream.two_chunks_overlap_blocking
>  not ok 5 so_peek_off.stream.two_chunks_overlap_blocking
>=20
> With the patch, all tests pass:
>=20
>  # PASSED: 15 / 15 tests passed.
>  # Totals: pass:15 fail:0 xfail:0 xpass:0 skip:0 error:0
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> tools/testing/selftests/net/.gitignore        |   1 +
> tools/testing/selftests/net/af_unix/Makefile  |   1 +
> .../selftests/net/af_unix/so_peek_off.c       | 162 ++++++++++++++++++
> 3 files changed, 164 insertions(+)
> create mode 100644 tools/testing/selftests/net/af_unix/so_peek_off.c
>=20

Hi,

Many thanks for your patch. I wonder if at the end of each
test, a normal recv() without MGS_PEEK can be called to check
if it can receive all the content in the receiving buffer and
check if SO_PEEK_OFF becomes back to zero.

Cheers,

Miao Wang=

