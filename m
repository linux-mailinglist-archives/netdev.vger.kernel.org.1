Return-Path: <netdev+bounces-77563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E3687230F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B1289BDC
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C3C1272DC;
	Tue,  5 Mar 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izBSssKJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBB8595F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653600; cv=none; b=l6BCTmH8QspPQG9szD8S0OsExmBcBXrSjHt1oddncR6T0xg4zrXMR1oIuYnS/islg1InVItDC83Lxria2R8C+yQu8uwpNlFpB6rnlw8V7n2EsYgWpNU3Fx1Yk1DRcf7Czd229MPPtYZwU7DdXfO7T0X0L6Ugll7I9tX/pg8ONcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653600; c=relaxed/simple;
	bh=2iI6JWzEmbnlcxf2QAK8yU0eKhCAyzGePX+Bbweqq6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHhX8Z+PousNQtQnxgaL95u2JQjnbZGV2ELMMQRo0Um1xYHaZDcaJpAC4OvinMZ9IRtaP+WzEYPffTwaPnif2DMXpLrynxawW2F9pbwPX1p4+drB+Ag+7ShxbgKijWwU97ZuRjji9F05FFl5UMNyDDYelKT5bmWZJTiPAO3ogUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izBSssKJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709653597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iI6JWzEmbnlcxf2QAK8yU0eKhCAyzGePX+Bbweqq6g=;
	b=izBSssKJ+8FGWf3MMiIjZ9LsjpGZt2EPS2X6W/6kK49EaotQvXL5sjkZ+F7VutbmOgZlNG
	EX3pMLg6kDWbPG/qT8xvZaiP5B2BQRvOjSaKb1qGa0ON8AcOX6gcCml8v5JXPcCLx3vKjc
	U50RtZwYHqlE7q6AHd/0aV5OmgWGaKk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-_jxvxlNGPgK-AjXQm1H_yg-1; Tue, 05 Mar 2024 10:46:35 -0500
X-MC-Unique: _jxvxlNGPgK-AjXQm1H_yg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a43f3f8d7d8so406032266b.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 07:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653594; x=1710258394;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iI6JWzEmbnlcxf2QAK8yU0eKhCAyzGePX+Bbweqq6g=;
        b=agX6hB7MsG67EThlfkJOkZgZjJZ/dnPMyr0a4TdSMZkTEFPKaAqqNS/ukqHWXsxiwv
         Tq2wiItDUU1iYUfLrqfh2FYJz5+JoOmwnbGfuOhA+XS/UBUINcJfBI0sPBLhyHEDE0vp
         sYnsXy6j63K2iph6M6NbOBb/WXQE3NaSWd5i0JZd/SxwYksHoUZacnv/WFZFkmTKR+KG
         Zu6UtyALaDAYmv/BXnPCZH8rzO6oW6jhUCvLkyNkH9fv0saA6kQz/xND+Vw3iRW+c1hN
         c3m5a19VfsTv8KOvQrMveTFzWtLeTzOT9M3Xn2zjYHIrtsiVxORRehHi43/9lnk9xvBY
         ATfw==
X-Gm-Message-State: AOJu0YzItclX6fgpA5zzoFBKlp5GcWutQZkSeBFaTEJhhHKgXIprweH1
	x4BXFQolYZasr+qylWwtnrm42IbuSFITQ1GtSEvneYY9K7Y7Ho2zYxPAnaOWHeMQX64sgJRYzR9
	bzO9mcSecyqC3sQ4AiEpGm7/K4UxJII62BJEkfGBkOhi2AlthejSrKg==
X-Received: by 2002:a17:906:f253:b0:a45:7d2d:e313 with SMTP id gy19-20020a170906f25300b00a457d2de313mr3211028ejb.50.1709653594711;
        Tue, 05 Mar 2024 07:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6vNyIVmBfDN+vMb+noq7A9NEup/xBi1IoZLy7FLeW7jO0urxEGbGP1wKq4/XIzMQN8+aCtQ==
X-Received: by 2002:a17:906:f253:b0:a45:7d2d:e313 with SMTP id gy19-20020a170906f25300b00a457d2de313mr3211016ejb.50.1709653594370;
        Tue, 05 Mar 2024 07:46:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a451ef20743sm2977119ejc.197.2024.03.05.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:46:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3C8A1112EF08; Tue,  5 Mar 2024 16:46:33 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, Magnus
 Karlsson <magnus.karlsson@intel.com>, Prashant Batra
 <prbatra.mail@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf 1/2] xdp, bonding: Fix feature flags when there are
 no slave devs anymore
In-Reply-To: <20240305090829.17131-1-daniel@iogearbox.net>
References: <20240305090829.17131-1-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Mar 2024 16:46:33 +0100
Message-ID: <87cys8d6li.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann <daniel@iogearbox.net> writes:

> Commit 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
> changed the driver from reporting everything as supported before a device
> was bonded into having the driver report that no XDP feature is supported
> until a real device is bonded as it seems to be more truthful given
> eventually real underlying devices decide what XDP features are supported.
>
> The change however did not take into account when all slave devices get
> removed from the bond device. In this case after 9b0ed890ac2a, the driver
> keeps reporting a feature mask of 0x77, that is, NETDEV_XDP_ACT_MASK &
> ~NETDEV_XDP_ACT_XSK_ZEROCOPY whereas it should have reported a feature
> mask of 0.
>
> Fix it by resetting XDP feature flags in the same way as if no XDP program
> is attached to the bond device. This was uncovered by the XDP bond selfte=
st
> which let BPF CI fail. After adjusting the starting masks on the latter
> to 0 instead of NETDEV_XDP_ACT_MASK the test passes again together with
> this fix.
>
> Fixes: 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Cc: Prashant Batra <prbatra.mail@gmail.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Jakub Kicinski <kuba@kernel.org>

Ah yes, makes sense, of course we should reset the mask when devices are
removed!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


