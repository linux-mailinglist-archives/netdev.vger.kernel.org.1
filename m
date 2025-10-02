Return-Path: <netdev+bounces-227660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06126BB5007
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0513AB9EF
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623D284880;
	Thu,  2 Oct 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQLrq3wk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2F283146
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433258; cv=none; b=HBxZh/GB6rbnsV8rLOCyxReNGo3HxwRR58cJq065gtpf+HGRSLT5G3D2V2grX7Gike4yItLCRzuTOYg0Te8jI7FKIyfJAca4ffRXJdhSJ7H1MJk08SRhBnei2E8OvX8ucW3w5S72Rlp6vIptqyf8FP2JzvhjLHJ0hhQ1WbOIOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433258; c=relaxed/simple;
	bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjYWV45QszMMkJBzpjDsfhCn5JjPt34yvfwuTnP0BLNKp/ZSwzyt834yovCUPFOWPJccNki2V99T3I9EyMGwLpLGJ+EqEJJ9domF/czxC7Bt+oSKoK5RDeXYQWTIHUlslxWBPP49+gI2g6+AkYYwTG03t7npSbBAalvSzfYLtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQLrq3wk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78118e163e5so2202534b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759433256; x=1760038056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
        b=hQLrq3wkS1w2Rst7kyCipFyYLo9UtOaIW63nK8eF3rG4SaClFLaBp3htRxxZv0yZ2S
         VcIL/gNs1k4mZ6hTsaLwKjBmuAu1QATVGzeUWM4r29vITo//dGXzY5KK9JPIaqUyxy3v
         lAcmdSQQswBG24pwyRqB4I8kqEv87jMBsdJ/FXks/Ic50py0BVx+b3RJGOH+qK6OFPox
         UW/AjWbCjJuyBQZAQ4KqwEGJE9JDGEvzgeZxL9i91YwSvucnYmepnll0zgCHei07BUj/
         zPoxWGtb/3FYrsC6j+NKmOMwgRg8T2ctNkNlFtvVieuaYvckp3j5zwgFOnYR0LpYCqIF
         F/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433256; x=1760038056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gdu7OvnE/BdPY8a6TV/kIJlWQ8H1vqfFXLxfYXgYTE=;
        b=aonlo+Bonkvwb7nt55PMf9UsXOCSX2v0eDQ55OXLyAJAgHYEAOv8jsG+9CMzSrGByC
         pcglTX65LOa7RSDPAfEa7rvioQOA62b4q781BLV1jdxf0KtUdzpg//gSwnolrdcwPeQX
         G7A6XZ9AVTYKskYAIJyPWs4iYNDpAxPbrz7O/uJtApDWB9YVMPcQlNG/rxaAbQqusbCu
         Sqherv8YfJxhpUkIfuagk2kmQm9crPWfSqFrB1Uku54AKOCYj2+EBEUXbkNBPIe+4PtZ
         PLjl6VJ5z/zEFNRz6nmaU14kFXb3VYKqc6YcuzrMDsNaYZuzVBJxeg/Q5duBa46GdDfI
         OoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0KiesbNrz7StxK1eTdo9UgbCk2WJaflKb1RvoJD7IVsdivPRb9/yU2klprZE52ldXaBu3pt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByuazMTNk9sAtoN9G99Kpxb5WAAkiaT4M9uACaa7GEwnDMsxG
	clC8VrXJIXcELhWlj2N7ITR+xXZeLUmBeXLvnHQ3b34yhM31/e52QN4zEq6YPEP78IL7FZDymf1
	yWLDlLK9oM8gKPgrEmGh/DdvwAY+CY2w=
X-Gm-Gg: ASbGncsNdcj3FRyCmIHpcGsJPGIZGsdUjVOhiH/eQmnvtrHV2iinIyyDe6bqH789ivo
	roMMEkx1sdSmo1XYBR2JWQbPG3x7hz+HVKCEplIAbofg0tyx6rgiFL9yviQiHv0Dgt5bEg16cyP
	4Vh0ztt9CDu1kse5PGNxX1UfWTL8qa1E1uW9r2aZ+ZfF0uDrwmxKlDPehv4/ujT6/333eTgo57j
	JBbNapc9Ty8dqPlBnTJvSwa2sNX9udcxlkEvACZdXg/XnhIrYR01iMDqSJQANmJbQ==
X-Google-Smtp-Source: AGHT+IFHSMffOMVezAKpxf4xflxQPXHC/9PQfQy6n4Qt8MWkSRyYgaxLIW31hWZlX2OEAHUKUARWDCpbLDiVfKNbRN0=
X-Received: by 2002:a05:6a20:9389:b0:243:b62c:8a7d with SMTP id
 adf61e73a8af0-32b6175aafbmr953767637.0.1759433256415; Thu, 02 Oct 2025
 12:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002091448.11-1-alsp705@gmail.com>
In-Reply-To: <20251002091448.11-1-alsp705@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 2 Oct 2025 15:27:25 -0400
X-Gm-Features: AS18NWBJ2McJoGNd_MZw_c2oTY1FRFEzCn1b6DwesYnkNNElFy-oHlpyddLBacw
Message-ID: <CADvbK_frvOEC4-UbuYixCu2RbQuAOQLmTsi5-sGnO8_+ZSpT8A@mail.gmail.com>
Subject: Re: [PATCH] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
To: Alexandr Sapozhnkiov <alsp705@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 5:14=E2=80=AFAM Alexandr Sapozhnkiov <alsp705@gmail.=
com> wrote:
>
> From: Alexandr Sapozhnikov <alsp705@gmail.com>
>
> If new_asoc->peer.adaptation_ind=3D0 and sctp_ulpevent_make_authkey=3D0
> and sctp_ulpevent_make_authkey() returns 0, then the variable
> ai_ev remains zero and the zero will be dereferenced
> in the sctp_ulpevent_free() function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for
AUTHENTICATION_EVENT")

Acked-by: Xin Long <lucien.xin@gmail.com>

