Return-Path: <netdev+bounces-49598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7847F2AF6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA80A2825BC
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A447796;
	Tue, 21 Nov 2023 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhLbzar5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AAEC1
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700563744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiDMghG+Flxsy1/Ts+2LH0I9Mj0dh63yWYboQjw4BX4=;
	b=YhLbzar5U0RM6/rDkx2Ycj2h7cJKf7GRlbjT63IJimI0ZD8r6VsE/5p11ZTvK/NTd9Mvmd
	ixfeol0Meh7HY0aNZ0LXl612ML0AlAQj1UCuHl11YX1Jn65vFzSEVLEBYONV4Tl7m2sdiJ
	OK9QNj1yFOH8UQW0GLuuj/npHAEmFWI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-AmyHPRDUM7KUDHVzMoeh3w-1; Tue, 21 Nov 2023 05:49:03 -0500
X-MC-Unique: AmyHPRDUM7KUDHVzMoeh3w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9fe081ac4b8so18975666b.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700563742; x=1701168542;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UiDMghG+Flxsy1/Ts+2LH0I9Mj0dh63yWYboQjw4BX4=;
        b=gySgUsaH0UxfeMYlkSiMUuM8g/nzueUOvcAh3u9QyqCb63BkDIUerGN2PBAsoxaG1w
         g1c3QQB+mlA9VpBT9e+JUPaREDkG7MKed33CpDpfYeE3cuU19rJf6AnKEgNRTCxJYLTF
         SSlkOB8wQjFGvCgUuUGpnUprBAvGVZdMc5uqc3vc7XoyVY0YUFoaYGxGvPx+uR7NsZ/F
         /x18YRKwoCUAbEit+56di80vt9NmL1tZu8Oe/Uz2BB7CfJol6zFouL2sJsmqbhTloYzO
         zbQ6NxPw9SWTSKh5/7iWhxykJeKKCGWXWylp8zQ331aBAYuRqUtoI+2CTyVTSIXZnbao
         7+Hg==
X-Gm-Message-State: AOJu0YyzbyDfUeoKEJ9SfdTctMKrxadXwNsi/pEbRgFegz1aQDcwLOQY
	3jSkJUaEkTni8I/DmkKBmxmWEU7Nu6HBDqcgXRXmm+G/6LlaG6W3+LwKPgHXoFWFokPSq5YOX5f
	+i7QMH9e+Gd4HBdEO
X-Received: by 2002:a17:906:3089:b0:a01:ae7b:d19b with SMTP id 9-20020a170906308900b00a01ae7bd19bmr979119ejv.7.1700563741982;
        Tue, 21 Nov 2023 02:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd+7Qdpd47XJ0PbtYqHKtcRMfbM2Cg5As0yatVia19icpDdakWkj/5dSH7l6+nS0prVP7g7w==
X-Received: by 2002:a17:906:3089:b0:a01:ae7b:d19b with SMTP id 9-20020a170906308900b00a01ae7bd19bmr979113ejv.7.1700563741649;
        Tue, 21 Nov 2023 02:49:01 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id lh3-20020a170906f8c300b009dd7097ca22sm5123883ejb.194.2023.11.21.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:49:01 -0800 (PST)
Message-ID: <08e17879fe0c0be1f82da31fdb39931ed38f7155.camel@redhat.com>
Subject: Re: [PATCH 0/2] usb: fix port mapping for ZTE MF290 modem
From: Paolo Abeni <pabeni@redhat.com>
To: Lech Perczak <lech.perczak@gmail.com>, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Tue, 21 Nov 2023 11:49:00 +0100
In-Reply-To: <20231117231918.100278-1-lech.perczak@gmail.com>
References: <20231117231918.100278-1-lech.perczak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-11-18 at 00:19 +0100, Lech Perczak wrote:
> This modem is used iside ZTE MF28D LTE CPE router. It can already
> establish PPP connections. This series attempts to adjust its
> configuration to properly support QMI interface which is available and
> preferred over that. This is a part of effort to get the device
> supported b OpenWrt.
>=20
> Lech Perczak (2):
>   usb: serial: option: don't claim interface 4 for ZTE MF290
>   net: usb: qmi_wwan: claim interface 4 for ZTE MF290

It looks like patch 1 targets the usb-serial tree, patch 2 targets the
netdev tree and there no dependencies between them.

I think it would be cleaner if you re-submit the patches separately,
thanks!

Paolo


