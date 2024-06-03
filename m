Return-Path: <netdev+bounces-100051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3A8D7B0B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAFF1F2104D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 05:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0069B1D54D;
	Mon,  3 Jun 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="p0YOH0Lu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489320332
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717393529; cv=none; b=NL3i92AF74CBxxHybuqZSfuTL6tCJzzKDzCFLv5e41ol9FTCnMxTZeZsNDJcs2zIrseCY18NdN4m5wkbvCJlhUxL6war9o53E6/ydoYQOlTK3g5iBYwvSOcvyMjnVRlE9AHp+FCCVGqnwDUmEfOtKOOJyi5L8vSVNaRIDwKWKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717393529; c=relaxed/simple;
	bh=KPKnGVWpVEgc8Gqrz6vUCSmBzBxFm4nIZ4pPK59St6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LB4pUkyY4+NNR7nBivIXd14kLDRP38kDSjUAgDiwGymeGJA0zc6WTymPO3a9VnqQr6BbNgrgkphYl1mFjgEr2ZtH2vePiIB01oEs9bTpmarpGZ0wHTP81BK/Kf3RUOZPFLAIDqOSno7ZgE5X9trdIZQPa+DiNB32UFR6yBiUPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=p0YOH0Lu; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b992fd796so732485e87.0
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1717393526; x=1717998326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPKnGVWpVEgc8Gqrz6vUCSmBzBxFm4nIZ4pPK59St6g=;
        b=p0YOH0LuE2OuJi073TF7Gj9esDmLkARjW7aOwK2HOOj4WbAansk1wkIxE2XwCOgfXN
         cqyg7SNAjR4oZ8pHHD1Bqk4BdmRkPqT39pOSAIFaTwGEuvGTtVbnA8N2g30P6Jn/5QBQ
         FIYT/diKIpTbJqI1d3rEH1vBBrXnOA7oGG+Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717393526; x=1717998326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPKnGVWpVEgc8Gqrz6vUCSmBzBxFm4nIZ4pPK59St6g=;
        b=JgGBFxEe7n9fLSfRbnwQt3LjFsBX92L/BUv3xKOubhPDrN2vTUm53bSynKbzA5QlHp
         ak0t4tvVH7byZBsEZI3GVauT8P3zAco/H4pvXoqgQOAGQy2J64CIbYAv8wpBFDTeBYwf
         W/stCI0nNcrtjKwzBSlmE8TvG8gXqJI2dJuLg8o8Tp0l7e/IhNymdQGkzXEoewylpf04
         ZKZUcYqdjsIgqmafYwr9LdYFtNVUMchAtV/fkS5KDYPGME1KdE4g5PutkV/kC95epK2X
         joUbfADNY1GgBRU7dpL/zQp8ipkrIKg0RQLzXvOmrb8rdI1IsQfmLPCnCEMxX/XVW0Fy
         MUjA==
X-Gm-Message-State: AOJu0YzaDIkZnwwLZPD6z2J3ON12/s5INjKovLKNcznRPWp5bVUucvsU
	s+SDPYItBXUVQP1KC7DD+gbN86fcztIGo4bEFD2W+X/FOWRm7g9JgpSSaG75+SklzFSL+9be34I
	tgKC8Q3njssqfHMYRZYaGor+WXwunjDIbqMbX
X-Google-Smtp-Source: AGHT+IFLL8MSI6WbUVQvroJz9ejvgZ+bu2gKUkZlbIX2qORoPKcEcJAZrK0WBmalEY0GvU9nhfg4Hl/xK3cckpZbz0M=
X-Received: by 2002:a05:6512:2029:b0:52b:8455:a9df with SMTP id
 2adb3069b0e04-52b896b8210mr4500387e87.34.1717393526215; Sun, 02 Jun 2024
 22:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ7MKoFSEzMBDAOjoUt+vTZRRQgLDNXEOfdCCXSoXXKE0g@mail.gmail.com>
 <20240530173324.378acb1f@kernel.org> <CAK8fFZ6nEFcfr8VpBJTo_cRwk6UX0Kr97xuq6NhxyvfYFZ1Awg@mail.gmail.com>
 <20240531142607.5123c3f0@kernel.org> <CAK8fFZ5ED9-m12KDbEeipjN0ZkZZo5Bdb3=+8KWJ=35zUHNCpA@mail.gmail.com>
 <20240601142527.475cdc0f@kernel.org> <CAK8fFZ76h79N76D+OJe6nbvnLA7Bsx_bdpvjP2j=_a5aEzgw-g@mail.gmail.com>
 <20240602145654.296f62e4@kernel.org>
In-Reply-To: <20240602145654.296f62e4@kernel.org>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Mon, 3 Jun 2024 07:44:59 +0200
Message-ID: <CAK8fFZ5S24+YqsTW0ZWCOU++ADzffovpty4pd0ZAVEba1RBotA@mail.gmail.com>
Subject: Re: [regresion] Dell's OMSA Systems Management Data Engine stuck
 after update from 6.8.y to 6.9.y (with bisecting)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, 2 Jun 2024 07:35:16 +0200 Jaroslav Pulchart wrote:
> > > Ugh, same thing, I didn't test properly.
> > > I tested now and sent a full patch.
> >
> > I built the kernel with the new patch but still do not works but we
> > might hit another issue (strace is different): See attached strace.log
>
> Thanks, added that one and sent v2.


Great! With v2 it WORKS! Thank you

