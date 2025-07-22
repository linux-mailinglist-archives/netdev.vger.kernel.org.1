Return-Path: <netdev+bounces-208993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FCBB0DF8A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA441AA4684
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEEF2EB5A1;
	Tue, 22 Jul 2025 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqBWHyYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E82EAD0E;
	Tue, 22 Jul 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195717; cv=none; b=GeNsNsHn67cHobJawUwb4zaQRwfvqD8yFKId/yE3tuerM1Gc1IyFTGXbCe93goHqNNYYsGHe4gr/bqQu4x2LUObzlvcbILJWl3WqV8RjQRmUWCvt6evhnhuy8Y5XWzhcVczHjb4IGn5+vYf+BuRF3YnoafuyAnwbi1Qg3RT+IGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195717; c=relaxed/simple;
	bh=4MtfDle0WG7Uv4F9z1b6HHt/I+hDlg5Sid0y9Zgz/MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rz06cJS4rx/Pz8rmUIugJEpQTnz9BsVHm42HcRo6BJndXobsDH+wqqyHhVWlJwtJx5m1MtxMlYh4XDpy3dnjYkBIUAVxOeyDAcWfaCqNvELuaonlSWQwh9dPZ21k8MP3FpaK2dSlatwWXxh5bbElGN8IpmMdlHmQXEJOIYxX5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqBWHyYr; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e810dbf5aso2642214a34.0;
        Tue, 22 Jul 2025 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753195715; x=1753800515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MtfDle0WG7Uv4F9z1b6HHt/I+hDlg5Sid0y9Zgz/MU=;
        b=eqBWHyYroh5SMHjYXw37S1jpVRMVJCqyb8IVfeUixvzzY/fG+g02Y7TBEDoVYsrkSL
         IgadErEoflSUgGz5iA5k5L3KIsPQdguzDr2td1QmMEaS270c4FAkpP28WS6HiFoZxlyI
         dlriJ+RsCGJSy1gF8ftI0dwk9YXMkQImAyrUlNAR3v9lN5TVLn3lPLKNUCY49nyT73Y7
         jeyVU51ewOx7zM/onSZiP9bmqzZzMHDahTZdKTB3N5z4H3yjPxJjyOtVmpTWafycZ+aF
         euHir7LSRqKUUC6mn9hT8nspI2rjnSBrrPsjdxwfilHr2uro7rF6ocDVFe+d0q9fpfFv
         xV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195715; x=1753800515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MtfDle0WG7Uv4F9z1b6HHt/I+hDlg5Sid0y9Zgz/MU=;
        b=OeLvkbRyCVReCnNBnM6rrTZNmpmn3Qn+ISHCM4AV3cQNVT3fH9ckK23wTiRdlQ/iyo
         InxqlYT16ATE2Sj/GwTkYxLrgHtHxsVICB3sS/QcHMqAx+y/6YtRmCbvnKU+ckXCvTd4
         orstJntSHPnFVF0+nmN3lId9oqqOyOr6Xz2U8QAQM4aMIQOw/FMLozEwjyAoI2gJYcDI
         3oksnDxwZblnNWucRILXyZR54JT5B5TnQl8zR5ZbZPkf9dP0iW/CbrFatVnJfDm+/+XN
         cnxJjblimhET2cR+KdhYi8sfMYYqy4dRyQBfvuWwihpOwNO/R0+wBKsXRBnyb0KrvZNT
         DA3g==
X-Forwarded-Encrypted: i=1; AJvYcCUSf7dXy8r3S6GocA2AiDK574hGjuTR07I6FUvnOOpFqyMsHf6Ro92ZqYJbK59NT13nbTGW0+KSATwEsO8=@vger.kernel.org, AJvYcCXbP1oZe/Gsl1RICWXMONd8DPJq5qUAnOXUfdHT122pNvulCxD6Q8dCHJVmec1sYgYPgFQcXDhp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yexmUfBZKe/c1oRZM9qjWoNB7/rGrOvDvVRJkXvwCGiHzM5w
	Xw6DxqOkgW63Z+v5IV7Q7zyribnNJTz2tYn5bBkAkom9/L2O/iK//+R/lXF02m6m2Wn+iztdopL
	IdCpZj57gieT54wnOFt/+4juQMgicY34=
X-Gm-Gg: ASbGncukt9SPnWrKM+LGF/6Ct20HE+wGxzvwOp5unf6KhDdHecC81T/hXx6aFFFaT8P
	YRV7Wb2rvv1Ty2rtwNwDEHYRvwuCg8Ropfmy4QeDOTIJShs2g3xRx/s1g9Ei5YcnB8n0Su001PP
	ihVxKMyRmffUJdb/b6cVd1yt6nJhcXnF4+jbbgxmm5vSM8qRkOPbFwARBZ3QBdNvtQ8FbXvaIGm
	NY/V0N1u1W4AJPJ9RU=
X-Google-Smtp-Source: AGHT+IEG6weuk3u01kWhYmKNrNFH8KtNbCdNFtt5z3JdnOQTxFy2cESFvYQBnksX7pF4BWCXErQiIra2xkerjFPulHg=
X-Received: by 2002:a05:6871:d810:10b0:301:db6b:45dc with SMTP id
 586e51a60fabf-301db6b98famr6726378fac.11.1753195714985; Tue, 22 Jul 2025
 07:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
 <20250722063659.3a439879@kernel.org> <CAO9wTFhghrrzH2ysTiBqNrZ1dbb001Y6rWYiKRTC2R8PBm-Zog@mail.gmail.com>
 <20250722073330.5bf59b6d@kernel.org>
In-Reply-To: <20250722073330.5bf59b6d@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 22 Jul 2025 20:18:21 +0530
X-Gm-Features: Ac12FXwSanR5YTRf_oRfMzLZcHJJHxNyTZr2BTs9dzHsoqX6MSu3EbQIzv3w40A
Message-ID: <CAO9wTFjkTbwiT3vCVX9j2UwFdF947NbxpUpzB9iyPcxYxARtUA@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please note that in networking we ask that new versions of patches not
> be resubmitted within 24h of previous posting:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>

Yup, thanks for reminding.

> > In the meantime, could you please give me some insights on testing
> > this change? Also, apart from the unsigned int blunder, does the
> > overall approach look reasonable? I=E2=80=99d be grateful for any sugge=
stions
> > or comments. Thank you.
>
> Hopefully someone reviews before you repost, I didn't look further once
> I noticed the static analysis warning.

Alright, I'll wait until someone reviews it. Thanks!

