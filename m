Return-Path: <netdev+bounces-151121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49E09ECE61
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2514C188D4DB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A602288E3;
	Wed, 11 Dec 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLZOFQot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55BE2288CC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926389; cv=none; b=V5tQkenLaoLaALkYdMXFSaspzXShYCFttps4uRGOBlHhlezykjBNZryokGXAyhtw16z92v0yCwUrWxhG05znz4YxXR1pV9G/FmZOuUi7exbRgGEURbyxBeZW3dWn9htliux1FhHrG3dL6D4Nn6qjPeU3Hww8i1vcuN6fDm51Bjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926389; c=relaxed/simple;
	bh=ryqjMepciPNN9yv8Ty70slrXmv0mRcXt093RJRLWSWs=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=ph57M15rs/t28u2spsDVYdUACsSPavokOTN6GG4fnVBd0pEo6CKec0nJcsZ3RZ1oAc1CuK7pxtsPKsWmz8WeMSFw9R85bLoggAjbm9w6MdGqx7I0Y62nL9cvIEy+JmHCkT3HijOfefZ2VtewmdrsNjO1i3SKVZkTB4y5VPsN6T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLZOFQot; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21661be2c2dso24495475ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733926386; x=1734531186; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryqjMepciPNN9yv8Ty70slrXmv0mRcXt093RJRLWSWs=;
        b=OLZOFQotWF1z2+doacgzvXtU6QOADpkAHsseMiU5/lWEZBlBZcPSPhqxTLUS1FZ/Vu
         cGAl6fcaRuD+LkjkBPB7YVfET2OobfFHj+OMogEIGlNB2vBLvikkxGKwoEkI+wrj2XbC
         tsifWKldffmZV9je4p36UK7cb95pXltlsO49AtIbh7Sd21mQ1ZSj6XmPCYw7PxUs61b8
         TBoUO40eVYUw2drIDvhGCDUvN+Bd18eAMpHtpVQd/30cfG8zmruca4Le6R6z/g9upCBl
         oPRCRBFSJs3xa4A5FHp4y9zCwa6n3lyPfBcIvOtnkph5oXvZYoFU2u+TJpS1OcIf+ZX4
         DLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926386; x=1734531186;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryqjMepciPNN9yv8Ty70slrXmv0mRcXt093RJRLWSWs=;
        b=W7xAclXQZeZKnDGo+RlEN5unuqB4T3Nv2OsVI+ikztmf9eHtADePQUhLBHyuvpZjlS
         nYNuanMOfI2vQ7H+9aTJZtkuI+b+sjarCFMyDB8PXX+Exew53glpFrZwuZ96bdI689Qh
         f3+o+VPeBvP4TGv1dqEwTJqCjcLiwIpTxkZD0VFMOgSUdhHwtDBfAvqMGLootnZWf0wg
         UOcoZM2QsJtDujfRsNSKPIz9a2rCCQUQrY+nezLmxZ2mqxrM2JOKOeSRT/f5XllQH/IT
         z6/DXLzk0M5rnGGA6KuHbFqX3o86WSHRhOe8nZiwFuaZGWXsYkV8n1XLp/z6JHnHMUnr
         Rl5w==
X-Gm-Message-State: AOJu0YyJ2UIa7qQbxZRvAlfelPo1Iz2QnB+jOgjsf0tctkV6nBZGTZci
	kr/fNMe4kXwFd20N+beDI8c5i81CBj9WY0h5qEuuPGEUEDzkZwN2RQ2bDZ8=
X-Gm-Gg: ASbGncs449EyurI/AggPhjlJdkmicBVCdWg3VMlP0knEQHObx5uSFJbcHxnVrk/8PvY
	RZ+tXDTCUwYeNPSFFfSoMXBVz9hUVgmeiVEc4A0qEv2c/waBy1RkvSXlfIqwQSdBvKlPtLE6x5E
	LTJq6CBHhclPDvCsCvGWhJ8bm6sYM1iIXvfa7iR5o085x3iqdKH2uNeCCZ3Al9nPPNEP19zsyMa
	mtcDHlFeEPMY+AWONYZoXpX/V3cVq0V6fISMr3LbCvwiSxEtplVrF42zWv6vUqQVlfpxA==
X-Google-Smtp-Source: AGHT+IExvm4CH0kQc+BCnohejXoMeP1y9hp6hHIdrAON/rzJsTHcJSyxLbak9fWZkAS7NWV8ce6Lkg==
X-Received: by 2002:a17:902:f549:b0:216:4263:133f with SMTP id d9443c01a7336-2177889ae01mr43006315ad.57.1733926386620;
        Wed, 11 Dec 2024 06:13:06 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2161ad52f58sm88788725ad.55.2024.12.11.06.13.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2024 06:13:06 -0800 (PST)
From: Michelle Bukaty <siyandamtonyama@gmail.com>
X-Google-Original-From: Michelle Bukaty <michbukaty@hotmail.com>
Message-ID: <eb1496e6a94ae1d4bd22752fa2c8d01047fb13b279ffd18b2f491051468efeb3@mx.google.com>
Reply-To: michbukaty@hotmail.com
To: netdev@vger.kernel.org
Subject: Grand Piano 12/11
Date: Wed, 11 Dec 2024 09:13:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I am reaching out once more about my late husband Yamaha piano, which i am offering to anyone who would genuinely cherish it. If you or someone you know would be interested in receiving this instrument as a gift, please feel free to get in touch.

Warm regards,
Michelle

