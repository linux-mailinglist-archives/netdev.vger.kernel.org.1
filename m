Return-Path: <netdev+bounces-184328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2798A94B9F
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD98F16EB10
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C171D9663;
	Mon, 21 Apr 2025 03:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzvYUJ5K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87D36D
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745205958; cv=none; b=oe0TBZ66TBntXoggG59FzWbFAJlHyz+eMJ+joq4ax75aPwbDZ2qx0Q4GlgRr8zDeNXFOLTjtea55SH3CF4BKnQDB9Nvkequd9dvkaK5j4MMPGTSH4BRIBLhx35Ycatltl8SUs/WjAGr7LSsHTg89x6RRpRsBApeY4VAYQ7gZGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745205958; c=relaxed/simple;
	bh=LDRqlt3pdVBe6W0Gqdk6DfxwzQkTyd2euV3LqI0Bh2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNN0vuMTIJq4AIoajCKuov6OleiBnVNfVNMsh8+EtAf7VDxnUOlA0oPJFCm4sU6OyViPzAZ2lcPD0/DV7Z2SRn0G8e4D0Vezcfis8QXkJqsf7UxBPKlmHrIuZYMmN+O9Ru2WSWBIB8QJnTQHPLZRL0RVdotPRmsUI6rmtHNyHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzvYUJ5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745205955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDRqlt3pdVBe6W0Gqdk6DfxwzQkTyd2euV3LqI0Bh2M=;
	b=fzvYUJ5KegdX4Hasas63Vum6d9W0OSFgX5N5/aNcWJ60XQcgBgEpG1NPJyn9E37243gUa8
	0EqdseaExa6YGGG0DHrMIXeFqBEMx55zrsG13sP9rkcGCIUAK6GGyH6AYFWGZAjymJVSXi
	A/M2THTUE2rxPYDzCOl3hmgm6nYvBAY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-OyV2KjFxPNyV0ibDqRuSNg-1; Sun, 20 Apr 2025 23:25:54 -0400
X-MC-Unique: OyV2KjFxPNyV0ibDqRuSNg-1
X-Mimecast-MFC-AGG-ID: OyV2KjFxPNyV0ibDqRuSNg_1745205953
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso4176127a91.1
        for <netdev@vger.kernel.org>; Sun, 20 Apr 2025 20:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745205953; x=1745810753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDRqlt3pdVBe6W0Gqdk6DfxwzQkTyd2euV3LqI0Bh2M=;
        b=ZJ28w7gLu4NcqAd2eRDCi920GtiEwoSIuKiyarlbHa19rCk0WSN1bRANQxLpSmOVa8
         OEENt3gz09afkQDDXKSiKrFkcUHP4xb/p6tIUHlNU9HndhLzmOWZjSshWFF2GYvYkjJo
         cgJt0zw85Qj+57JQxqEqOZgcyojko6FhIqU9Vc5Bq3lxUreswYGtvNxj5ZdR/J+H4E4Y
         92ZHsnuKL+U/0n9GvUJNmQbJNduu84aDXGHBd2nVcu0ng5V6p6Q4yBoWfia9VEH/LRFO
         2DcYOsZo/HpSzpoSZJCZNCUguOJ7D6s/hA1oqrvlyLzaMpp3d+GeOWmnTDKv2/H6/ijX
         VHtA==
X-Forwarded-Encrypted: i=1; AJvYcCUUCRhPPsxFCZoRnP8UZJp3XotpYAguEhxARdKIKvz458Z/6BslEmGU317i3pGoDito3rIFahA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/ACz5KRjpJupYu1TMT1IyjZlflnl/SHRj+yfFHjeDCvWjA7x
	fKnc6rmtwn6BraRGblbOB5Tozga4CjmDdjC85jZD4je1t8yUePdsrQXKKInN6GDCXfP0R1u1Er3
	MMI1IG3OZqYbD/wbxG7cS8nUHx6pFz6jIsqYWTxK1TsxWnHLN3zftPuawFWdFsK0oX8oJyn0au3
	6e1Hv60rksIYaIAVFSq8oqQyn15Dct
X-Gm-Gg: ASbGncvd9XpS1Dc4isJq5O4Dlz3XNYvb/hZhKwesEYERoTE3pdfX8AyRDb3eHvhr3oG
	pUIJ86SrMpeFi4hy19XS8yY166PhZ74PXH6pqJAoBZeAjL1BCRZ3Ai5ffUm5dwu1QyRYxLw==
X-Received: by 2002:a17:90b:4d0e:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-3087bb698dbmr16031395a91.17.1745205953161;
        Sun, 20 Apr 2025 20:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRn4aaJLEWKifGdZtxb0xG0ZX1rnp7AGSHkwS8cLatxxEFkRFOLg4s2lSpvKjRkSSHI3FJP0BYoc1g+518R0k=
X-Received: by 2002:a17:90b:4d0e:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-3087bb698dbmr16031376a91.17.1745205952711; Sun, 20 Apr 2025
 20:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-2-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:25:40 +0800
X-Gm-Features: ATxdqUEzFhmXZvex8E_M5MI68rpAe_dfLzO2jQT5TrbK-mfz02wSE_-vO-a54DE
Message-ID: <CACGkMEsR-t1j3d3Hh7FkHDWrjCRoyB17JxCwiN8Fqkh-zJiyVw@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
>
> Introduce a new parameter to enable users to choose between kthread and
> task mode.
>
> By default, this parameter is set to true, so the default behavior
> remains unchanged by this patch.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


