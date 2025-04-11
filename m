Return-Path: <netdev+bounces-181764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CDA8669F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315024A5180
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858D283C85;
	Fri, 11 Apr 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+XhEpOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CD28368D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400723; cv=none; b=u1loQZ0CY3mkKCrl1mspIECiwpmCBOrG42D7T0p1swuqF+GDRBaBYF6pBvPz7XfEsxlii9A7ZkNVrWxm22pgkkyP/N+VLb/ShCiRmDIRxEFCROz9mJ3XIPwV7IWM4TcWJoqoyWVpeu2Fq6gOT6tz/udgtd2hXzY82iPc0cajZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400723; c=relaxed/simple;
	bh=0k+RRSIshNmJjhWDP0sDhEaJ74DfqYYPE9poDNlKT+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAiUQrRz5ighoOmV8FL4RrE7C8EKiRJPbjDwRMnW4VQ5++g4jTnAEPpNW1ArP4Rn0mlYBfYHvKh0039yX4grZZyI95+Dpq9AqeZHYXGKcg3bqUMTgb4AOU2ONdzD8ybRIdyXlvtxLWhPcvgGOPlwwj+7kgDRJQqc2PgXa/HJrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+XhEpOS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499614d3d2so2725941e87.3
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744400719; x=1745005519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxYbMPJ9/3WWUWhZ50uH3rQ7QOEKEgqBV9xF/3bzbaw=;
        b=D+XhEpOSTY2iRLZNvIyJdESthVk9ylxkqTJv7FokRICCYftCzTmK6xnJDojYwW89ji
         2AFg7ifCj9Veb3HJw873OFYIKlcMfUwFcfLXsp2HXhuitNezaqLNBx9+23vmpUuXzJDF
         ca90T4zKAs9ScilMaX8jACwZ2Mhsys399QeR8BUlMz18Lo2iclMaj0m6Lx72mjpYlKt0
         IXgJRRcRWK+9UTF/5UNRWF9lWXl68EAgpiNrsN5uxI+dEGhs1HdEZ9zBFtlaKhEkzmcC
         3nYCrj3X6NYHQ+cAsW5szj5GX+YQyRsmMSNEWT/iB29b9JyVms4Kg8IkxxE2Wd/7Up6f
         I76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744400719; x=1745005519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxYbMPJ9/3WWUWhZ50uH3rQ7QOEKEgqBV9xF/3bzbaw=;
        b=P1Uu5xa7ld3Blb+kf9uHAUMSjwCDDafKC/DhpEErln6n0IHELa4ud6HmabxJUjh0f2
         OxgrQd+uEsMe5CFwCWyx41voabqiYue9lY9L9ueQA8UkUK/VT3z/rOrIajh97hlwdL0a
         jt6ZbhPzahZgKkNsr7Fl9GABPMjc5T+f2xFqtzUpcDSFrK5HJ2q9bifwlDzzNPiM9q3+
         7Kvy0kB8VNPKjpTPjY57u+ht2iFDY6yIZPdYcAxUSpa6yHFvFNnp5OizlEGi2f9QrACQ
         +hG6dDASW6PIZjiXArWbnishned/lLnEekH4oOQzUAzP7WyPjXlVMP8g7XOQ9/1Zh0eT
         xuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdkL9BibNevklJKh1ZTxXKR03P0vH6QmviiLwbs6LJeYqrFHPqpujj8zupxz/tbUhmDFJXudU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/mJ+dvRGPmRU28X1v7Ty32n1YMe6SGwSJ3TMLjU4gIJ0YZss
	TJAnKN/DD803aLKmpL8wcEceqAy4YzIMDxTZQuf74H2Be2GKqDiKqKyXQXWoAcxnKXNCIrS0Rqq
	e0yOVd2EiANsnIAoZt++XK1ij5j53mml3CHaU
X-Gm-Gg: ASbGncslwFTu2KT3Zlwu6ZOYDW5y44UqIrQEGp904VHaua4tLlA9DZ0qCLJ8CVkTB1w
	PemCX0/mdpoYk4GPUWbwwNQ4FAZrwz/xkc6DxZYj8TwcSLSlcoC6q6D0h4K9SSnwJc/0bi3ccoO
	49y2pmLJzzQfVUrA6zxHw3
X-Google-Smtp-Source: AGHT+IFQGifPI7ndsGleSodbkGXAUKIZ07u6ZNQvsjF+hIGRNgR8glp2xAOBfn6+WWgANIaxwBpEYzIsWHLxnZAfzB4=
X-Received: by 2002:a05:6512:1154:b0:549:55df:8af6 with SMTP id
 2adb3069b0e04-54d452d543amr1362508e87.53.1744400718920; Fri, 11 Apr 2025
 12:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
 <20250407232249.2317158-1-sean.anderson@linux.dev> <174438283512.3232416.2867703266953952359.robh@kernel.org>
In-Reply-To: <174438283512.3232416.2867703266953952359.robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 11 Apr 2025 12:44:42 -0700
X-Gm-Features: ATxdqUFdZE_uhkHLsbxiOOiN0d_S9dmu-M7D17wvEEtC9Aa85-uCx9f3jAHFoIs
Message-ID: <CAGETcx8FVb91mL-LYN2=7yJGMaVsadpe_WiMn=OkEjMEHdJU3g@mail.gmail.com>
Subject: Re: [net-next PATCH v2 14/14] of: property: Add device link support
 for PCS
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, devicetree@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, upstream@airoha.com, 
	Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Marangi <ansuelsmth@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 7:47=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Mon, 07 Apr 2025 19:22:49 -0400, Sean Anderson wrote:
> > This adds device link support for PCS devices, providing
> > better probe ordering.
> >
> > Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> > ---
> >
> > Changes in v2:
> > - Reorder pcs_handle to come before suffix props
> >
> >  drivers/of/property.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>

Reviewed-by: Saravana Kannan <saravanak@google.com>

