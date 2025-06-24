Return-Path: <netdev+bounces-200736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0598AE6A0E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B283A7239
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABA82D29D5;
	Tue, 24 Jun 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOXknBKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CB2C158C
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777268; cv=none; b=QQ9O1h8V7du3EHouiyrvFPqsPN86CJrngk1qgTYwdIvtwAtZDsVyWIlD7kRVTmEriNXiVA+mQUWUoAkJPsmoZtw2Xl0MDjyp+cydxa5YooVolHRSJWgYNGQwpTFxnK71aqqEeTwBGZx6CV6ozijYTEeMboclNDOb6xPEllc7MmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777268; c=relaxed/simple;
	bh=u2d7eJCKe5DCnYfNBfH6WO1R4lI0JbsHGipx9VDfIus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbV246/2+vnKPvqz2mjke++57UNoOHjMUdSf2niqOzXjrxe7zix0TjK20sLZZNnm3N93SfmoXicQeRftyIsOm/l6A4wcmtC+ydLF3Go6x529y4BgSVLSDzmrlDp+Ln8+B6dS//YFOb2w4V1ukHf1O1/bc2r9mkJKN0yXNfT/dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOXknBKk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43e5c2b1aso4900621cf.2
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750777265; x=1751382065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQO6fYX1tlaCa6GUVJou84I6jO1suX/vUfVUEHv6exY=;
        b=WOXknBKk7uGBw6rdVE5R0digHMNz8DSxgLm6q+m30qVfOr2QVL0yWiP5/LPq1V8PQL
         o+xBEAg0nHvO1q1Vc1/0PfgCBo/vBIdufl/RfLOItOPk5CgjTteW4L73mqh/wiuZFA8p
         WxCr9NpOIZtov/LSN15NVryxmwFD0WMELmGA8MNcsTaBoKy9LO21nob61hCtKglPuXlf
         KftyNB5GzxZrPyEFG000fM6i0OEGxjWv8DjZ1crLVtivu19lTCIcG6l/k2qb8MaBDE5l
         4t5yAeViqUURZoFdPXDEK1rjsHLe2rMb3paj0y3lpKkyXowGA7gUPsNziYcifRTQSTh6
         bSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777265; x=1751382065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQO6fYX1tlaCa6GUVJou84I6jO1suX/vUfVUEHv6exY=;
        b=MQzCFsV1i1WxeYhx1f8Kx+L9N36nHc7zZskL+cxL04CLNjxTUINOQoAeINiafrHHM1
         W2nmIfT5agSvTrAW61zSM+4LpDcdSxWccy3S2Hb8vHaW6gd1gZ7H2wbhw2K04anOiSW5
         b3biIu3JR5m8P4bMoBv5pG54JWmnuMsADnxE5HI4a7Kzy9fXCfcJ6h2hToRrqiSlrWNx
         LPdmLSv86sf9tAC3YQ+FvKZmmv2RiYzoDOtKBJmYFKgWhnZ24wztyDHwVEchSaavbgDU
         jrRdTok4elcND4svghp2Lxn7qcJNAEYHSIv05qf0h/lh7I3NHdnJ8lCZh7U45z6cPKrm
         K8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUgFdW1J/iFEToAozfOjJh6QdYDBopXg63waNvFGATsfENroMzy/kd5lzHZYvFIqqKE3YOdOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUhOcw5kMA9276+m3o5fq1V2q3D+FahhVnYSR9m3Qx1hKUsDN
	9c1JIBmP6VMU5pXe/SS3YhLJ39hiELJfmH1CA9nKRQvJ1CxiciCbdmeSbTs9fVXo5ODpu0hUFjR
	FuvcwWSK8VMOfwH6q+qLu1AiovutK2g==
X-Gm-Gg: ASbGncviCH4DjUHmyYJvOV9A8eVEZ0i20lGknuPpk9EUnV/6hpxJIk/QvldVbXpWjmO
	sYt+3r2ksXV2HhoABK1IFXNjgT892eq0aQNdt+Sj+hZFTlK9+sn5MmF7vGbUDXr+irFANW0va0n
	225ydXMK0sfytl62IHAowLAjGMEeDrIayTOuUGRWJikdh/nnk1zcohxjS78qv+
X-Google-Smtp-Source: AGHT+IE0ljHiktg4NVYgb076Nfck8KzSkJZB05NdRXc0RtjMZKBVrSnblsKKvmTOsUyU8VFIpenD34VnJy5NnLRf+W8=
X-Received: by 2002:a05:622a:1347:b0:494:b829:665 with SMTP id
 d75a77b69052e-4a77a2628e3mr91307701cf.9.1750777264979; Tue, 24 Jun 2025
 08:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617153706.139462-1-guoxin0309@gmail.com> <20250623115702.76bdd8a2@kernel.org>
In-Reply-To: <20250623115702.76bdd8a2@kernel.org>
From: Xin Guo <guoxin0309@gmail.com>
Date: Tue, 24 Jun 2025 23:00:53 +0800
X-Gm-Features: Ac12FXzrrFIcIna0mlmYuKfdr96KECwkMXIetjDZTbnIIdA7GwBaU8fXyTqGwkA
Message-ID: <CAMaK5_jGfjpw5nqi2Z-a_nHNTvjj=KAvwSw=bO=FhbgzBpXHUA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: fix tcp_ofo_queue() to avoid including too
 much DUP SACK range
To: Jakub Kicinski <kuba@kernel.org>
Cc: ncardwell@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jakub,  I will add more info and resend.

Regards
Guo Xin.
On Tue, Jun 24, 2025 at 2:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Jun 2025 23:37:06 +0800 xin.guo wrote:
> > If the new coming segment covers more than one skbs in the ofo queue,
> > and which seq is equal to rcv_nxt , then the sequence range
> > that is not duplicated will be sent as DUP SACK,  the detail as below,
> > in step6, the {501,2001} range is clearly including too much
> > DUP SACK range:
> > 1. client.43629 > server.8080: Flags [.], seq 501:1001, ack 1325288529,
> > win 20000, length 500: HTTP
> > 2. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> > [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 1 {501:1001}], length 0
> > 3. Iclient.43629 > server.8080: Flags [.], seq 1501:2001,
> > ack 1325288529, win 20000, length 500: HTTP
> > 4. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> > [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 2 {1501:2001}
> > {501:1001}], length 0
> > 5. client.43629 > server.8080: Flags [.], seq 1:2001,
> > ack 1325288529, win 20000, length 2000: HTTP
> > 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> > options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:2001}],
> > length 0
>
> Looks reasonable, AFAICT, tho perhaps there's some implicit benefit from
> reporting end of the DSACK =3D=3D rcv_next..
>
> Could you please add the info about how the packet from step 6 looks
> "after" this patch? So we have before / after comparison?
>
> With that please resend and make sure you include _all_ maintainers that
> the get_maintainer script points out. You missed CCing Eric D.
> --
> pw-bot: cr

