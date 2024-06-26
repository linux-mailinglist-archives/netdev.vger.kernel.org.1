Return-Path: <netdev+bounces-107043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF6918EAE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287DE282324
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6780190680;
	Wed, 26 Jun 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhLKg8hG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B719005C;
	Wed, 26 Jun 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427141; cv=none; b=M4PCa3rvPZVlOSsYdpD6DRqwZnVzFstH1LxHPArrvoZX4MpIq0u2juRJr37PPgolLnA5URlFXMwa+AlCDW1z5CB8/8NcLtzhuhItYv9+0Ny2Hs9fcxW0iN5dLgrx1zQrurM7wn9m/p2pg6SJvHXRxTgKkv//ML2xMD4ilxn2qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427141; c=relaxed/simple;
	bh=8RC4RoOdepfw+QoKH1SDT3cAhXv1FTN2Q/e15hP70WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0OfY82goySwkfBpUX9Uhhxq1B7Vw74HBo+euuJPE15wWInhXkbGh5EjZunLCJIwbil5v9yVAnHNHEmdkNrnbgJOFqmB7aywm5fmY67QQTrtBTsgMIhY7E5i5SHqREc8MwUNQsJzBZvZ8z49jD09zUoHFiumbVTOc4GIgFJ/XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhLKg8hG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c86869685aso663771a91.1;
        Wed, 26 Jun 2024 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719427140; x=1720031940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlrWYffJsTAsz9VBvDLLrbP/qPvWI/3vn63/l/yn9OM=;
        b=FhLKg8hG7Nmp+0o0hjXGerIFSVxmFtYuUGqaH71ubczfnxLdlWwzl7uUbVUO14xViI
         vVEEehUeXLnRzoCoKHZuzqi6W6B6KCcsL7QBDDgOWDzlCLCeeRKReS40ianG27fICbMR
         r372ycNfS5zNJu5vn81Em6bPMFxfKutBmFC73A/HrBBNsn1kcV7zFQqsLeySMyYk1b9p
         xL34GMo2mVouYkYrYYEsza82hns9P6UIyRXuiuH0WrqQ7dGrbfXQjshCv8vCiX0wBtIz
         YPdRT59j1uLF90/4SQaj2XamePeOinxJfZYMi5qGR1UZoDAfUh3ojFNK9UuYTLxhch8A
         5KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719427140; x=1720031940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlrWYffJsTAsz9VBvDLLrbP/qPvWI/3vn63/l/yn9OM=;
        b=gHZ6z954drfx1NhjIHVFQlYt9HFQ7gzfYCoOoWlxkp/5dFo2UehB3bUqyQAA0UUMKv
         czA+lwKe9VTDPDMQxoQa8XOW2P7GyF6jWZ/mn5AC2vOjhXbZ+TZaDZ3GECFMZnV1dIUv
         +G16TkyHKKAbMOcT+7M9uPIN3iu7JTqlv2tLvnQ1lfgBh5w9EfuJevN1V6z+1rBHGiqK
         FjfPQX3wlClhsMpX9bRpog+iu/oipRhJsRiD/ecNd9pNzf3fbdDzOfbOiQyByOqZ1VOO
         P0/+LfC1rwVtg+rJ0+RtKu7RfmCrsvyzDua/X3nZt/AhMdMyUhGmYeLg5dAKYqOVWEaB
         a6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXvsF6Ax38F6XiltJBokrHfe1qnDQMZwLIBsfAV4QXD0lxVOP+XjGGen6fnpfvlhk0MBzSy1aqdgx4t+EJgdFhTSBVrnh/P3zn95SyBRf77uyh6g0Hkan1TH0PXzmxz8rzhdRmm9k2kE7B4iBE4Fc1UQ+hUJX9H3oK/3tNUIpDyZg==
X-Gm-Message-State: AOJu0YzEiNt++I8WnYDwFw1wpyMXD7OhhK0ALDHvRSD0enOf3U9z5Z/0
	XHMBplQnszdksFD3Knap5dfMFByE+m+N95QFn3rg+IpR3HpVX+NVUmhg8kEHwcS3riN57dHaBK2
	r2H5DbbvGICoyDSraMQsqTOBPV4I=
X-Google-Smtp-Source: AGHT+IGzh7OgcwAD1W7O2ToIpYiNPYaELd/OyNMBI7wyg0Qn9LTacpa85jfZ+S1NzS3Y42emCNPSM0U7vxCnFynye4k=
X-Received: by 2002:a17:90a:fa96:b0:2c7:dfb6:dbe9 with SMTP id
 98e67ed59e1d1-2c84298b2demr12120553a91.4.1719427139827; Wed, 26 Jun 2024
 11:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626162307.1748759-1-Frank.Li@nxp.com>
In-Reply-To: <20240626162307.1748759-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Jun 2024 15:38:48 -0300
Message-ID: <CAOMZO5CQHMzhvP9KqPahWdeVjBvqk758uY6wMzVO4oPrt=pECQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
To: Frank Li <Frank.Li@nxp.com>
Cc: krzk@kernel.org, conor+dt@kernel.org, davem@davemloft.net, 
	devicetree@vger.kernel.org, edumazet@google.com, imx@lists.linux.dev, 
	krzk+dt@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:25=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +examples:
> +  - |
> +    ierb@1f0800000 {

Node names should be generic.

