Return-Path: <netdev+bounces-187148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27EAA5399
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633B01895B7C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89B1EB196;
	Wed, 30 Apr 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF1S0Vdc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13829408
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037273; cv=none; b=EbGIEKUaPT+EfQccAgcjdOo83MRCQ+IBHmtaYCpZG8XogbduRifq+Uf4tTAUzY857VgGqIro+07xaxYgRqCvlt6Y7i/8qwHOfIGeNg6oL+sm31/4VzgjovOozaFhH5OsFjpfyxebmqgrabSw5KYuYthk0Zw0rs9YNGO6tS1sdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037273; c=relaxed/simple;
	bh=za7xdjLE9bp2NMnr6s/Q5MyeV6qERXmYYVibZOeePI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdsGwx8mOFjnrxMb769ru4R35Ayv4IFFP5eGKBMPFmVA3riuSxTJLITlGHHJUuVkDqGdLFHJAu88QhK6DbjMaQAARy6f1awXGQ8hRuVF9BhypMM4mAQxX1VS0CU9T2Q3MJJe1bU3m7d+GJM+d0Rc0ZnoKafUHqxPo3X1CY8n4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF1S0Vdc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac34257295dso16380966b.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746037270; x=1746642070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQqDlcZHlKX6vCp3zS/Qk4GtsSiia+cM4MSYqtKcMHs=;
        b=OF1S0Vdcf2A9z80W7fcAPJenQDXM2wAqjmq/dLTqhappLLujiyXjlIZKSxuVmDxg8y
         JUytnxEmtXNKLyovvMgZUSN8+nbFuKDrBZAODTzgotnVl/L510Ks7mUzhcMLlOodK3Lg
         riK34cMTkqPG/Nu4fgWF76V6AFl6kALw6WlFawY1VtnWIzg11Vh8j0fQcEXy6PojW5ii
         KTvYuiPoJObMg/S9OTjiH5NXDOLhceD2lqKiUhw0zYTgl/xnkUnjOTLmx7Uz31ZbTWIo
         dzE82tGaMiS3pZF/Sn+FxJqd4FE+CcMn4TkKW31pJHeMzEV3vukiM9O0g6lHW/kyn08c
         wK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746037270; x=1746642070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQqDlcZHlKX6vCp3zS/Qk4GtsSiia+cM4MSYqtKcMHs=;
        b=Zl5pWtwuo49YU8d+cnmP9sr2gRgVttILLqGD4hP5uUhNuH66xikuY8sq0XOVml9l2k
         uls4FPOQFzK+NISJ/nyPeqc6hqjFAHp1Wh2J9tyTI7b6xsoZ+tFYYx4aPG0VcoNekuw3
         +F/+sW3JbtvoV9MjnTHfEf+ZlF3WILrolTOTCvmJBs1WLJftzSaLWLhw9RxKiHwQ6/Vg
         YZ6eCmzHr+SK86GjisUk+6TSi6bk0CUCqH+HXJBj2LRAYL8NcGrNmgYKEyB6MtJPufpi
         usfyz47VGPWnL1sx8hBUzQUobKiHKMJYmxfdO3KqFSDG8x3N8pG/56ft30NKZF6GmD4I
         b02g==
X-Forwarded-Encrypted: i=1; AJvYcCXlpIwXu0EraAJQmpjMorWTaPlcgF1O8U7UtfMwed07nNoOa+SpS8rGFbKGJgzqmIsSWwivXwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykpkk4PueJqNuf2xxS3mE4JpMzM+A2wkRE43HxCtT/0YD3CBTw
	+TsGV1g/em+nlfSJOS0cu0P3PbG3xE+JX6yZ2WSzDNBjI022EMM/yCeNgQOx6QCV4RJuo4jdNE7
	NADdmkbQIOhwniHYr/V8tw2z0E74=
X-Gm-Gg: ASbGncsKOg7SOlhfgVwHgE1d2qNftuFDNKTQbSeW+PX9StnnPxz1jL+n1btbM3DQ10c
	bjRDF+72JlCgQlYvhlxryXSnto1RgXQ/tfbPJo8S8CAhHlNy44EpIfx5dGdBEdhZbEYrY6Z+RVB
	dNGzB7HdV/CKSY/CJUcW0xZt0=
X-Google-Smtp-Source: AGHT+IFWsVi6IoH6BfgcKcg5vmilVdk+v3ykK3VxShp5N16rkJHxuTuhOv0ZjpySQzEFcYlgGAyD+PxKyQSXuyLP6UE=
X-Received: by 2002:a17:907:944c:b0:acb:85da:8e09 with SMTP id
 a640c23a62f3a-acedc5deed0mr429040666b.21.1746037270101; Wed, 30 Apr 2025
 11:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430170343.759126-1-vadfed@meta.com>
In-Reply-To: <20250430170343.759126-1-vadfed@meta.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 1 May 2025 03:20:58 +0900
X-Gm-Features: ATxdqUFeMX9b2Neh4Aj_5wp0FYIoHHfhxMkxHsQ2UX7_cLjpSBFL5xRDGg_zAdM
Message-ID: <CAMArcTWM+4hry2Zf=a8eYH54icov0J73vnEDX79RDEkxd6wX2w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: fix module unload sequence
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski <kuba@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 2:03=E2=80=AFAM Vadim Fedorenko <vadfed@meta.com> wr=
ote:
>
> Recent updates to the PTP part of bnxt changed the way PTP FIFO is
> cleared, skbs waiting for TX timestamps are now cleared during
> ndo_close() call. To do clearing procedure, the ptp structure must
> exist and point to a valid address. Module destroy sequence had ptp
> clear code running before netdev close causing invalid memory access and
> kernel crash. Change the sequence to destroy ptp structure after device
> close.
>
> Fixes: 8f7ae5a85137 ("bnxt_en: improve TX timestamping FIFO configuration=
")
> Reported-by: Taehee Yoo <ap420073@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAMArcTWDe2cd41=3Dub=3DzzvYifaYcYv=
-N-csxfqxUvejy_L0D6UQ@mail.gmail.com/
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Tested-by: Taehee Yoo <ap420073@gmail.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 78e496b0ec26..86a5de44b6f3 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16006,8 +16006,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
>
>         bnxt_rdma_aux_device_del(bp);
>
> -       bnxt_ptp_clear(bp);
>         unregister_netdev(dev);
> +       bnxt_ptp_clear(bp);
>
>         bnxt_rdma_aux_device_uninit(bp);
>
> --
> 2.47.1
>

