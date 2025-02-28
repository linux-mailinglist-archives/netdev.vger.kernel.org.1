Return-Path: <netdev+bounces-170819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E6A4A0F7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B86164C62
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B81BEF9D;
	Fri, 28 Feb 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmburJEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A861BD9C9
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765270; cv=none; b=n94dV6usnpSqsvbZVlPCiX4BlDIhLPFeSeLFagmVBESKTXeM0nebdpsxOJQbhp1xxScRe8WxnE9cayf4EyYEyvZ83l++XFpdO4XCK21tHtLn4RjnObyI6oPldir/5OyiO5gUhnbc1bjBwcT232KaNcVC0OfzxTEbi59275/Hz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765270; c=relaxed/simple;
	bh=MVdN+Ynhk6hW0AoqcVWiXQSRY77vMUQ2esikVFNpBsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+LB+i68Ys3f79ZCMOvmKb9MFzRlfu/8ZHRsTPABlkLyh/yGoS5hmAazNMRfJ151F4DI3vz1F9W8FGm5FIBiSJCdCrP7swsjnAUc8oFMKDhntuJ7xNlX4wroWHcIfLP5CU8ZIQZ21mLdVbBXJ3TOCQLuhGNQ5JJL4pghgL7pF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmburJEE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2212222d4cdso5025ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765268; x=1741370068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVdN+Ynhk6hW0AoqcVWiXQSRY77vMUQ2esikVFNpBsA=;
        b=dmburJEEbYAvMH0BtYHr9T0NL1yuOzVWhewEl8QJ3TOmvZgYFBTmfr2emNbhNiSKu3
         64szk5oVq1iprD62lcJsc3h/z+sN/1dHAB3zHdq4naVwAI4jT6rPtHR2AKT0SEQedGYh
         IzP9az1Fl+oftJpIVEDULUJ4qMrGGN8xv2UOHK/DH2BZzIlJm7dnO2cHPFs5pYq3SdG4
         W3g6P3th5N3Hd8ABKlLP+03s3xyAelTv+oqVpZjRh4nub7j/vRVrwHch76LWWnTbtiR2
         bXNFGGkrS3e3FmAQnoQf/NbkJInTCz2xyd6vUZBGA9FHxUG2kCI2DcEQ7nl0Acq9iYL3
         kDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765268; x=1741370068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVdN+Ynhk6hW0AoqcVWiXQSRY77vMUQ2esikVFNpBsA=;
        b=a7LQlkB/GyWW2HUR2wvvFCN0TJwM/wfHKHjWkrB1H/q9/BX15t9QJsG8VgPNzWk9A+
         V8dl/LmCOM3U5tshbCCIjs8EKYb9SOdTzwjP1NGG4erwEXWkSt+IssU/NHuasol93ztM
         d3ge4Hsb4H3+b24RrcFYuqlQVAxCfb6HycX7ysHQa6GtpDZsC6BmkAE+I5WBxgL6+FOn
         /ZFnmINK+UgmPRfJbKGFIhujN94W0ZlfrNm7+mLEBPMlrwI4J2e83Y9xBOW/rHNd2gIy
         SLl2ovElGNfJdEraz8aGZoQzwDMDklc5W0F07VrR0dc38NZjgBIXk9YofuSjKoi9skc8
         A26g==
X-Forwarded-Encrypted: i=1; AJvYcCVBuaJq57FiTEAGoY8V4SYTmRj75a1gKyXtD6k3WeC+yi50WILq/LN3BgMYy7+ByE7i2Tt3y6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YySqjyeNdwoD6J+8xl6CZX2+Eo2sPO58J7xlPkHPKPWv74N8MOa
	7MqsiDHSEnu0qwbIc8OjHW/ZHwQdJkSYqyUSFzexl+TiXBnX3YbI5J/nwCp00Olya5DYpYasdjl
	MzoC4FeMCDARpHUlkAAWPfSoXuuBaEC1hoqhm
X-Gm-Gg: ASbGncuyYtdQMbUJfuTLiEyywhq7aQrVum3kNcG/IS1uE3JdykBnPOvK9MIV4d+Vb8e
	3JG9xEc+rbX78ZdhIPxLQbaZhN3oFnjsgDOy2GbrKZbG/LPWSDrrj5LOVKarxc1AEdyAbwUmaM0
	abrhtQXegGoc3hhPuunH/USNuVyVjbQzuPlgJ1fQ==
X-Google-Smtp-Source: AGHT+IEi1GJa1ouQSpWyrgEKl3mQ6/UYlJL5ka9pnQRHnSVcZgLz6o9DsV78DeV0jZalRPXA4hRIE12rVD6V9nVNKoI=
X-Received: by 2002:a17:903:22c2:b0:21f:4986:c7d5 with SMTP id
 d9443c01a7336-223696de7c2mr3116025ad.8.1740765268370; Fri, 28 Feb 2025
 09:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com> <20250227131314.2317200-4-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-4-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:54:15 -0800
X-Gm-Features: AQ5f1JqXlAdHVmjzPkKtVSp2C3uZIGoF9V5WQHlbifvqRCMBHA7nvr1Tvs3T_Ew
Message-ID: <CAHS8izNAVdzjA=pve2nhk+zvYgsTgWAcrUBCJo8JEguBrd9DRA@mail.gmail.com>
Subject: Re: [PATCH v8 iwl-next 03/10] idpf: move virtchnl structures to the
 header file
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:17=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> Move virtchnl structures to the header file to expose them for the PTP
> virtchnl file.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

