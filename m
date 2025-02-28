Return-Path: <netdev+bounces-170603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FFAA493F0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859C016A9E3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040E253F08;
	Fri, 28 Feb 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vj71o07E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAF253F13
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732513; cv=none; b=t6+wPr01TLPauzyNTVZSL1V7rJbNSK4zXCWdzG7c/gJxLKCD0rYxGDlf42Qt9feJU96tP6jK8wT8vB1zpvbWA8v2+4vw0DNsn53OeXsTqPO28duvJWK4HTLk5HN9CYMWLhJ7Br2aSi2s48+fg421ATit69jqdgwVU3FdA64IU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732513; c=relaxed/simple;
	bh=LZZ9jWgJN89HTnl3LE3UbhbcdJnL8R00Geyvxn9UOsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwllzxOdeDHvJKsR6QiKM1vB1XT7x4LL9tJz7C7pJrQsyUWyHEe0e916HsRGo8pu39tQaU2bAxovzmRC/S1JsJVFrsdVFDHI1eNAw1ymtCsYD2xNN0toSIe7iTllFXXg5L8noJBMXdMw4G84Jow7gUjpbxJD60Fg8ShTWejMJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vj71o07E; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4720fb0229fso16643521cf.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740732510; x=1741337310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZZ9jWgJN89HTnl3LE3UbhbcdJnL8R00Geyvxn9UOsY=;
        b=Vj71o07ENlkmSfAGe+5P/HQnZn+01ZcK42viNI6DHKOGv9sm51KmFobC8q14e7utZA
         QybZ3d2cUX1DWd5kqymBSbqv+7nUgJ1ako8dbobrP0nVK9rUtQx3f3j+529ytas9kQLl
         NPALeUEl0DB7hH2pTrg3UgJ6jjArZCpWMi0DDviHndByu1eEX87mnZvyms/MVtfW511E
         /vRjOZQn9EwVmpDIlLfs+N9G4gXRu/1twYwBSNZ9iJmD9QsWCUt+kceOk8vMwOIuciYc
         jIJ7/SJF633C3fcaghmWPrFA5i4xRGqESwHftjMyEWIvYFDv9AY7o9dV6YH0/uCxmFIV
         qGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732510; x=1741337310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZZ9jWgJN89HTnl3LE3UbhbcdJnL8R00Geyvxn9UOsY=;
        b=heCikpBFV/G6dMFI+spmOv+gcDncC7YI8LhShFCiTEUTwgIhYSMP+SSu5NyMUx95Xg
         sDb/18CEA3cpKDivGzmbJnWblIh9FStb6K7pLIuhpJtG2X3eEXB1BqWR7EH5t6Ztdh0a
         BVKaxTpPqDYSge4WbX1F0hYEUS4ebbKVzie5cW+UxXZBc+AGpZgwuFz0U7f06gS+6xQy
         rP5Hr2qCPDeli73/zzxMw43Tm5YPbmNFFjPTvzq5dw6Un393pBejhVCrolpHZ5GQV9nP
         DgsN36VkVHPmTTiMXfBDV9LocfunhKJppzNH3QqevTMIoU4elq4mG7GhsjEXEp1Yef3M
         dXlg==
X-Gm-Message-State: AOJu0Yx48/KgwtyP68wm8k1Lr8hiFS0FB6QiwevEi1ZfbR5VhKhNbf5q
	fBXc/H1lWL8QxWywkCaIf5+txiOArILSR/w3XhLhRanVm36JndhieaYqlofwELR4XeQjMcXQjMy
	pdK1nnBC4E2XCLfzjCadZPDoVeSH3SK+oH7UX
X-Gm-Gg: ASbGncs/zk8zfiUwNCCCSyTyqNkr/WJmHb4balwak/14+QOiKLEmT18eKV9k4P8dUoI
	o4FjBf9Ie26d2X/5rmzqrGkNOArvUpWxwsRZabg2XnvHeRaktVD3dQywol4DgErd0B8Er3N9SFf
	oY5SinXJRv3AQdT8MXXanwfIrFeMI0C1RaWwCECZDg
X-Google-Smtp-Source: AGHT+IG9tOW5h/IcPipfBAVFtiWzosZr+/XmRmEb1E8E3daJW8ExIaIl+jI6yRvr1tV2/a4p1j6mrg/6FbWG/tQZhtU=
X-Received: by 2002:a05:622a:580c:b0:474:bc62:bfe8 with SMTP id
 d75a77b69052e-474bc62c075mr35089511cf.1.1740732510116; Fri, 28 Feb 2025
 00:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228045353.1155942-1-sdf@fomichev.me> <20250228045353.1155942-4-sdf@fomichev.me>
In-Reply-To: <20250228045353.1155942-4-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Feb 2025 09:48:18 +0100
X-Gm-Features: AQ5f1Jowlo6bKAascIHpSBqBB_2SPaIeGAO0UTM_du4RvcOMwfECWfQ5I_Y4oNY
Message-ID: <CANn89iLpknvoU+XKRB77qrbXrZv_XOSjvbYUZVbSAwHtTotVDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 03/12] net: hold netdev instance lock during
 queue operations
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 5:53=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> For the drivers that use queue management API, switch to the mode where
> core stack holds the netdev instance lock. This affects the following
> drivers:
> - bnxt
> - gve
> - netdevsim
>
> Originally I locked only start/stop, but switched to holding the
> lock over all iterations to make them look atomic to the device
> (feels like it should be easier to reason about).
>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Eric Dumazet <edumazet@google.com>

