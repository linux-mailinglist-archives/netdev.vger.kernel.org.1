Return-Path: <netdev+bounces-187816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26876AA9C01
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A87F7A1019
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC7F1C1F12;
	Mon,  5 May 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BenqUuzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7286342
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471211; cv=none; b=r0BrVokDdAlMZgxJ05RJTj45ib5d5k6BZRVIhKqTNg2p2gjC2dz/plvTqii08urLKosRaD/m8HZHNojLtXfvS9Ri4abS+OSzPDiShu4v01k16UPDYM/MqWZqa2ApgrZCV3Vg8Eti+XKpjQWJ/C5A64Y7BTPD6YRFnrHgbEC4tN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471211; c=relaxed/simple;
	bh=FuIgF3xpl57BQM5gb5B/cbVDBncuVooGE9Ug9ln/YFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUhMFtelFmz8VR2Roiix5kyIXiE3kCUNEHZhCJqzloi1m3gqN1L/+gTG3uZkQjE+DRDVrw1dvmH5pX3vqepzbcv4pOlok5vA3p4P+sK/4oV8Z2AyYJsye2Lm60wHsMesV37Ij9s5igBOMq4919nZR8yrdSuMfn11ZjNqnzPIYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BenqUuzK; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769aef457bso65942461cf.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746471209; x=1747076009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE8E7uN6e92XnvlGgfyB3YrFpfW0Jvu0vZ/ENMS40h4=;
        b=BenqUuzKezca7EqaIsKxozXkjSLDs20oh5msqg2wYm0IssM2pv5zYuFWGmgNn6La0P
         WQ8ZW/fR/X8x2eJ0uacneYWJv57kqAqAOPDTf6AfeZ1zWUOqLXB2eiEKQ6jibkYYZWLT
         hyS8AYaN4kuh0wPRUOlROPpd5XcX593VZOCuIC2QPEXfcXb/x8SkOqynb1bfFB4TYPxj
         4H+P5cgcA57pc466bV5xvfGod2lgaZrlbfr8UeLmjraLB33qFVx/zpFIt+rE1PkTbAU1
         0i2xPUmK0z5YOvTv9MXzaFJrqoAG8u+eUTYozFntOZc8FXPPrc2txvvI/ucyvwZBl6If
         Oq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746471209; x=1747076009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE8E7uN6e92XnvlGgfyB3YrFpfW0Jvu0vZ/ENMS40h4=;
        b=rQsYoYqGdsvMmmE/gFAz9C0uySMRxTB0uy0XHi0OGKGk4g1mbC4/qTs2yD/EtMmfdB
         aKFHl4V3ykcGBCDh201tyxuoqCbNhjO5IKSQWRyiegb2vYQXC/snxLxFlomT7WCR7knS
         T2lj9wHoJ1sX3tyFCGLfH9Cjq+egjc2IxBIFwRuR6+uo87oV6qPy1xSC6sG/MK3Gs3Nv
         l/amvaVwKPxUWoirwHMR+MXTQQQHC5Y7QRmN/1/DjhFXAiTZrs4YuvxBYWUiifjAQTN5
         rh+NYEeAQF8aKk9vxRxkFqP7r1tNF6Kzz04NwT5SluVY625+vIG30gxiy3sKFb37YfqX
         /9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXS/fMBLoX4uBiKS6YS2xLUpYq9lrMzLK8uYbFjL6/qLGg248E3WC/0+Jse4loVg6Mg14KX+KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywql4i6Ih8IiG8RmsPZ8a+CqtqUaUvg05ux3RZR/row1N/ksq4O
	i80RlGCRZDufPa09X4d0fZO3t931hHhAeXkMJ8ObUu0TVNC7YfO8mP+1k+rUAS8fYlBmramfxzN
	vtO/A8eGF1wSC8bqZgO75u0ypyVvS+JyX/EsR
X-Gm-Gg: ASbGncsuE/NTYhoGjw8N2cqjxuHHzKv3yRmJyXCjBwNc53ozUU0IZ0bPt8Hl44TGsBG
	2IXWFQJ4gEMhVG4aO5jKBq+ayvPUB2ZpTUU9WQzb11biFpVUkf5EE5wjkijSQtJlWjmDb4tA56P
	yeua3fRVQZeYu5DZa7dJ8=
X-Google-Smtp-Source: AGHT+IEySOd8jG/a7RMEmZco3yglzRd4YyLNh+zFFYwlCG8pwIkJpEe0KkaJ3MejnrGXn4ZLZqti1s2EYZeSeG6Z6L4=
X-Received: by 2002:a05:622a:1101:b0:477:e78:5a14 with SMTP id
 d75a77b69052e-48dff3e1b73mr121558691cf.3.1746471208555; Mon, 05 May 2025
 11:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
 <20250321211639.3812992-3-michael.chan@broadcom.com> <CANn89i+ps_CozfOyRnKav0_LUmSekJ9ExB5JkDbTAVf_ss_98g@mail.gmail.com>
 <CACKFLikb0+uBshZvdNadKTbD0bRrH1XvrTchjuv5Kty0T4+Zsg@mail.gmail.com>
In-Reply-To: <CACKFLikb0+uBshZvdNadKTbD0bRrH1XvrTchjuv5Kty0T4+Zsg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 May 2025 11:53:17 -0700
X-Gm-Features: ATxdqUGdkDnLPM1nN_B7RSwdRJB8oY5hLHPPhLd4Y_LJzTQ4mMWFh0xMN9VLXD8
Message-ID: <CANn89iLFwUkLP+EO1YJe_ynTKEz69LJtGW43Uht9aM18K3e49w@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Linearize TX SKB if the fragments exceed
 the max
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, osk@google.com, 
	Somnath Kotur <somnath.kotur@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 11:34=E2=80=AFAM Michael Chan <michael.chan@broadcom=
.com> wrote:

> The patch works.  I forced a smaller TX_MAX_FRAGS to easily test it.
> But we now skip the warn_once() above since we intercept it earlier.
>  Should we add a warn_once() here also?  Thanks.
>

I do not think a warn_once() is needed here, GSO is pretty fast, in
the unlikely case this would be hit.

You could add a per tx queue counter, that ethtool -S could fetch for
curious minds.

