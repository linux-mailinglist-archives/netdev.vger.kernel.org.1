Return-Path: <netdev+bounces-244825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C68BCBF545
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4D6630194EC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93A322B62;
	Mon, 15 Dec 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="d1Be62oE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B23242A5
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821589; cv=none; b=BH+0/wPT8ZyGFkGGcfSW0wfs8xY4SBySnTc4h6kpAQciObk8EUZi6uR2HgHJJGAI/9MzGftaN5hJUslTDb0zyjr150ljpVSmgUaw/qgNhSuosAdKDOuKMSHdEkb5W6lzQUBVUJVMWb/+xcTt+gQOqry+OEWiVZ0mHA/OLNpjj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821589; c=relaxed/simple;
	bh=I94Aq9J9oeQ3d4zMJRDc3HsLz0QlySonGNftj9fAHw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWoRp2dBF0q+9QpxmpOWV3rRyAZI1Ox9vySbacaQbF9YDZZ0UcN+WHS37TQatPlzBaSIAiFd0gFMBTlP6yqPLAveSDhGD/kuigKWpshNLlpNfkfxO9zMftohFzcKtskahQICqZp8UYNRFFf+zpoi04MwzzY/Fcc9LSZPIYRDIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=d1Be62oE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78c6a53187dso39490027b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1765821586; x=1766426386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I94Aq9J9oeQ3d4zMJRDc3HsLz0QlySonGNftj9fAHw8=;
        b=d1Be62oEc+PYvlB9MgnkrA3Bjc2a1RUW7j9bEoncMquMqtu/k5sjLTZ4irNHxWEbu6
         l3VJaRtCHSNn5Q1/2QzLnCraTLjqO4S/5DNMJ7a/WiUG1TbIct9za3rp134oaXycAqDO
         znIGNQXNSDsEkBuUpTkW0ei9Bb763ogwEPZkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821586; x=1766426386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I94Aq9J9oeQ3d4zMJRDc3HsLz0QlySonGNftj9fAHw8=;
        b=ClFZAt6OOZmbADPrtvrYZTaVuyzHCckzmORl9PnXeAE8SGmho+bd1arzR5NvtqpT5s
         3L8crtlFdTj8JqoB9pFsZcHCoZJDeDwafvH4FCRX6ApsFPfYi5RG+kSOnuQmGnd6kEHn
         xBWeBYregBvZ4ym5NYvEHrPSGqux4UluIrtwhGftyDNwfHDvJ0H9YgvLoV3h/qIUWdN8
         UHD8I3KKGF7Svegllied3YQp2GrBlP3eghIAUGqQ3fBQ91qpgGr5ugy9+UvvIf2YHwJ4
         BWfXW6bclOa8zrhwb9RB2R+d4VC0kwLmOsf/LkAibMv58AYQPKmoxbijXZOTFd8dXNPM
         fXeg==
X-Forwarded-Encrypted: i=1; AJvYcCUUC0pO7s5NbfgtsyWkW8NHHYx3KnTNRzoKZ42kmyhZSHSEdTV2MpJR+x9maLybPK3r9QyMS7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoZNCw5Rsr/fMkrdcCvJH/TUOiYv4cNYV3jKhwY4McY+EIrZS
	mlalVZkdYvAUCpm1JUXkynTgPpKFRMmSzewi/MXxi2Clm6HzVqXO/jlhpggsI2P5jU3mnqNAcOL
	tBH+zFsJBfBNQe7eQ6Z0t2CkQKoioqCRjxF3H6kUMIQ==
X-Gm-Gg: AY/fxX4Bbntq+9xWGl0h1bKw+DtS4nihqR5LUyTCBYOl+ErDkHjFl3zIRx0rAylicfe
	TxhDsj/r8pDvdtWwP1z3NC7lpkVdmRH/CoSvmOMcblF0bf31WZGeGIdf4hd7oCUFuldXMgWuIjg
	VdiAO54jjUYdU7IfmwtZCRsG7e7x9ZbEFkVH1Ycixi/nFIzQsBR/WISTT3CX1WKEtq1ideUqSk5
	XGlssWqwiW9v0Rbz3yIoQHJorV4eq8yrBfbDiCX4uHAfMXZJfpREvvjaiTP3BCxFP3vJt8E6Q==
X-Google-Smtp-Source: AGHT+IHP0C56FV3OMQJ3oSJZujQ11oK/ho+SXlxjeQngz5OiRFIplS0yEVUIcjW0Jg2645GGhETkV1LfJ8NAWoXWa2M=
X-Received: by 2002:a05:690e:191a:b0:644:7182:daab with SMTP id
 956f58d0204a3-6455567beddmr8840168d50.89.1765821586156; Mon, 15 Dec 2025
 09:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213002226.556611-1-chaas@riotgames.com> <20251213002226.556611-2-chaas@riotgames.com>
 <007b4664-acce-4e14-b284-a36dd3a88e8a@intel.com>
In-Reply-To: <007b4664-acce-4e14-b284-a36dd3a88e8a@intel.com>
From: Cody Haas <chaas@riotgames.com>
Date: Mon, 15 Dec 2025 09:59:35 -0800
X-Gm-Features: AQt7F2rRTafpK9F-Uy7yCKfrtdJmlMVHKRNlpyjlNgoCcp_0FDWeJ21XSrz53MQ
Message-ID: <CAH7f-UKErFLc2MMQSgVeGLxHcfF4ZsAC4-QfLSSzf_3y+-uaEQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v2 0/1] ice: Fix persistent failure in ice_get_rxfh
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 5:18=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> thank you for the fix,
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thank you for the review!

> next time please do link to the previous revision and add a changelog

I'll take note and make sure to add it next time! Thank you for the feedbac=
k

Cody

