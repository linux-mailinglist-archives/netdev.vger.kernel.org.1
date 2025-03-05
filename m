Return-Path: <netdev+bounces-172107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B608DA503FD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44DD67A577B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFC2500C5;
	Wed,  5 Mar 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLTxe2Ua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A824BD14
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190280; cv=none; b=IybJ79Oz5nosWR0VU1WYNE9gT0kLvKQDi+l7JB2/+hYbQHQ0anAtGiKA6ocbxVvG27MnQgc8KugpZeIjUDSigJKcqLjwBzlMsKj3UJ/fiWYO/RYIezo5NOYIkCsTRDIv3DvxmqpmZZh7On6mtag0EIzX0M83Gj++sdnJzkJ7Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190280; c=relaxed/simple;
	bh=SBXDCbn0EDo86vXEbThyYq3aa8VNEEwSgVJZ2OVcX80=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=YIymYcQOWJGkgKA+NiJ90QyoTzcmbgoAcBU+m1QeZpCcd3UofxYysZss4zFXOElgBxG8UYfzVqbBSQrhYTwrPviLP2sDKGt8NJ54csvMAXb7qpBj8SuoBoJ1Adj/xteiHsXfWu/8xg5I1GErqpUvcmoXmGX5dZZz3HICsG/15BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLTxe2Ua; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso19561035ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190278; x=1741795078; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBXDCbn0EDo86vXEbThyYq3aa8VNEEwSgVJZ2OVcX80=;
        b=aLTxe2UaTIcIZ46DoiVaIEFM9XiYGzdWqmkFHk59KHRLqdbQ5yyfE7OoSQxLhTb4LP
         OscUJBwlK8bcKZCnZI3dCnyzxEwfoyOewE6hBlH1p4cYMijCx/a9cPQW08CH/GvpLMZ4
         gwgvpSBTss5IC3up4VQdzWeodzbnx7P+eRWJku97+gEgsr82BR5byPYJ33uSytBSgLAC
         EGQct45p37vpt4BDPvdfh95MXcXG++1xRhOWudlL5bDokAwVZKWFa51n33AgqkpkQ5f2
         9freIPVSrRvwZrsBjmSPFzmzCEDCkJ8hf7SQH/cLiMGi+QUbs+iTow/QdHTNUuSZ5c6g
         8tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190278; x=1741795078;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBXDCbn0EDo86vXEbThyYq3aa8VNEEwSgVJZ2OVcX80=;
        b=n1hTSIZCnwTrbJlhochCnDSaxf73Br7cFo9dDwuv8sPCOHAGU3r+LZ03I6zsB4XVZp
         saQ2Jdqf2Q/dlufIq/qDvhcDGkXQLFEAvlsFjaLvwTzGrzX/aEJVtNjzlpZqgBi3KX4Y
         mTEBW13fe0a2K2uGzHCropuNa9btx5CEEnu3CXTeE8ia9eJZLdNZkEPssJiNdOZ2TVmU
         SHAf5Nn6OHNdNflDbxPiHdvihLbxQ7Qk1PaxIBTBKxAyecgcXIgz6uUw3r35cGXT0Ch/
         ySiLCsaQuJ27+DMw6XiK9mDiuEO/DRUzVpct0lYDQpUzvGEZuB4rLNdo3+YfSc9E/IbP
         Gq7A==
X-Forwarded-Encrypted: i=1; AJvYcCUxXcETEzjAMuUdGhS7T+P91pkF9KN2eoMJhrht/zSd6a72WxQ39eDDVLK9wEKbHLKzcWhSzhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxulCfelLpftDk8+aT6dZyW7O5T3D37wqBAq+NRzNXs804wS8XM
	4n90Iwskftgb9frhapDWJ/GLu2xixH9hyxTRwLZ46eIwtlotnaeOJMudHuzBXhE=
X-Gm-Gg: ASbGncvCIV7Ca7Z/hpOB7HSBL1+0h0Gc1j2qrVIkBGtjB/CR/hz7YhYrOgqegcqAoMn
	J1Fa54hpN/DV1s41XplpsjvG+rWdfEYciOckqwFaL9o7Xm1VeIBwbT85JQVz4LnP7Mjmm9N+yd0
	kxnmz1coQAMwCEB0lT/o1aojJUxhGMjjN31CumtIWPRg4GD+slJowVwljNlF2L+ECfcxKW4OlHL
	yTCl3C6nKl3jCVVPPjBgK9xjcw08eVMV+jlejH2SQ9j4yWrwwxUbscFcOT4SEcuPFTb6JF9u3Nb
	1PyxVH/CtedywE/d5z4b7GE+/HUyrvkiM/EQKgVUkKy7u07yP22sb4iA
X-Google-Smtp-Source: AGHT+IFqZ9n2z9clq7yXPXzRsuuTmSmkk2fQSoKEiB+wdKH7Svdh9Suh0CvfLLXiIShgHOgz24tXvQ==
X-Received: by 2002:a17:903:1986:b0:220:cfb7:56eb with SMTP id d9443c01a7336-223f1e2905cmr52630175ad.26.1741190278121;
        Wed, 05 Mar 2025 07:57:58 -0800 (PST)
Received: from smtpclient.apple ([2407:cdc0:ade7:93b0:b315:7434:2d82:f682])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d26acsm115503575ad.9.2025.03.05.07.57.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:57:57 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] sched: address a potential NULL pointer dereference in
 the GRED scheduler.
Message-Id: <DB9B87BD-C829-4A06-B692-77324096AF4F@gmail.com>
Date: Wed, 5 Mar 2025 23:57:44 +0800
Cc: juny24602@gmail.com,
 netdev@vger.kernel.org
To: xiyou.wangcong@gmail.com
X-Mailer: Apple Mail (2.3826.400.131.1.6)

On Wed, Mar 5, 2025 at 4:05=E2=80=AFAM Cong Wang =
<xiyou.wangcong@gmail.com> wrote:
> I think the whole gred_offload() should be skipped when table->opt =3D=3D=

> NULL, espeically the last call of ->ndo_setup_tc(). Something like:

Thank you for your review. I have updated the part with my name.
I don't quite understand why the code would send a TC_SETUP_QDISC_GRED =
command during destroy. I haven't found the function that handles this =
command, so this part of the code should not produce side effects. =
Adding a check on the outer layer would indeed be safer. I have already =
modified this part of the patch.


