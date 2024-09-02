Return-Path: <netdev+bounces-124215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DC49689DE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB71A1F245AE
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF2C205E06;
	Mon,  2 Sep 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iduNpBCi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44419E985
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287138; cv=none; b=k+nBm+jzfCaeR4Zyo1/0avhl//FcIdMFhpYQtt3peGjphKrrMJPl8yusyJmG+Kbw1/zAGUo5k5uQ3tJV2hX9wv1pV1yO41uYJXao5jYLAuvETVVTKpkifrGxtQmYqLWxyrMybOUHFmh3Caxe7IupIOMUazIZ81wZ+amOmszP0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287138; c=relaxed/simple;
	bh=9NUgNclV+AxZvF+36YWXi1LxNWSBtKhJKh7gtq3LPSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL3dUe74oO2diUwuIdz+GiGERQsrh2hMHpR5l/3Is6Spmto9jAjsDopUCEGMS4+WSDmbkavb3vrnK5zM0UFctmiRZh0UY2M6GR5+X1iA53zCRFCm/W/lStfEoMvlwAnhqU5LECegm+1w4eN+ThhhjROE85L0dDU93O1zteUjFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iduNpBCi; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39d26a8f9dbso15585045ab.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725287136; x=1725891936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NUgNclV+AxZvF+36YWXi1LxNWSBtKhJKh7gtq3LPSE=;
        b=iduNpBCixuf3ShwcJQzOy5x/5WiopF6AXsweQXNB+o2aPkv+6++2E1RkVu86C+adme
         gLGTwG+LHpL6SpiAjFMTzrdue5Cq/j1w0OFOkASFy1bjjI+dJ/jrxzawjZ2HM3e/3yON
         09kJA274cePQ3AOjlUbqFzJk6zk10STP8Dwg7M4dt/dM1dc2glq6SAnUhWyeZXhkXl39
         lGCVPMQhYKOKaMRwvThbaMj0p1puDTCvqMM5YkU4l3MegG19KII51DM9NTDrKxafVtyg
         C5+9b8Q5o7xv0Fv8XkwtIRy6VlSyRQDqA16Kz2gn8ZjzLti6lYoW2p3f9DCXwLdJHym9
         kKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287136; x=1725891936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NUgNclV+AxZvF+36YWXi1LxNWSBtKhJKh7gtq3LPSE=;
        b=QVLXpO2Yq5cplj1CjI8/l5r813tXDCRHRbrY3ApGKhtsOtkzLKfPnQx8WW2MOMzFGj
         1/U35wJexRiaviVweV3/EJoQ1ysUvSCkkhgm9a1/jQTaEF+km0kzQ7q9c0bddVX8fq1m
         6z04qRNIVbDt1WFvwMZdekDAtRv+9xGZghZVzjqSkyAmwtaZaGDs+Vf7nKuUYcsOKU41
         OzYHAw4+gHQGQjCWYia8gGxtTELtnkqKDsMrmTu5TCrICGMc/ynij92LZFY6gWPBLU6G
         eD0/JurZcG3fNEPRqNMaVSmdwXrblQJUQlRb0nOKKleLMwjYWWlTCkvg5r65fp8R4ksp
         dJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCWBTYJl/hyNhbkR5VGdoDS/hptg3sHuARhOqpsqL8R4bAOnkfl01VK5rsL1h8DL3Y6kwZrGjsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfs8IivBO5SaEulrDwkpeDXYohwQaCZxubTj1mAB6lHFxxKoBK
	FUCg5pfMumrjKFI5SUb5gebMlad57pxGTHkcNDBPFDqZSFcgDRVdlZIaHLdEQ1SUITBu3FD4pyf
	fuxd+X5xFkdiyVyT3yY0EAyG4DuU=
X-Google-Smtp-Source: AGHT+IH3ij6xC6P2MMlkXwmNokS8SXzDaPpIB/COg8n8WsHg4DY5zEAFjvSDGzd+ag5cT5dVV3yYbbLaENqthFj4V2A=
X-Received: by 2002:a05:6e02:160e:b0:382:64d9:1cba with SMTP id
 e9e14a558f8ab-39f4f55f3d9mr87622665ab.19.1725287135784; Mon, 02 Sep 2024
 07:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902130937.457115-1-vadfed@meta.com> <20240902130937.457115-2-vadfed@meta.com>
In-Reply-To: <20240902130937.457115-2-vadfed@meta.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 22:24:59 +0800
Message-ID: <CAL+tcoAjjWNPcxFxWdWf+AJJbvzZJpfv7w+JfU63UMe7KMp5SQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID test
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 9:09=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> wr=
ote:
>
> Extend txtimestamp udp test to run with fixed tskey using
> SCM_TS_OPT_ID control message.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Thanks for adding the combination test !

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

