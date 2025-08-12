Return-Path: <netdev+bounces-213077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41DB2341A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13C2179424
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA912F4A0A;
	Tue, 12 Aug 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ZHR/dzBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFB61FFE
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023533; cv=none; b=Ras8KIznf898nOr9vnn2yVGt1cuTlD1uUwr2ojOWHHLroLwZIL+INYgKumCHscFrkELvlhBCkk3qtxgaX5qN6s3klL/YCllO6ynvlI3GX0dNiSUaEDXJGVuyhOksBH7KkwGaSBN6dE13GEEQJzLaHmoGfIXGZfNa1G9prQtI/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023533; c=relaxed/simple;
	bh=i+zi1mckHFSs3/o6uZ08YJLPYCf+2Co1lbbh8aL603A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIzKg14gbOb8phX82Ov3V/Ec+60M97TLfQzCG1inabkEFio93WZr07Sm/0x73SKg+gvwI11F1huJYfgwsk/yCIZIk/m80XdB62EyC4AFus2xEfizydMFttC5P/3EyMzkBdVx12B4aqi45pFX2uJXhFGUHI2CpBF48iiuwNvC9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ZHR/dzBb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bd050184bso7457326b3a.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755023531; x=1755628331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOzgIuE3vZOPdvH25fCuhzEe3nU6ZEctPzGHGhjilCo=;
        b=ZHR/dzBb/pfA5F81bCrKQjQyvq9CPPVVe7qQB0KidiGXhT898wgNjOpPOEA4tgiUtN
         YV9jVBpzfMIm/6/VgyRkAE3liwRmDqmeEl8/TjkXhYP5/FA4a5jDfQRvBFx2D/2PTW8q
         M22wfLY0YZnsBrNkBejo3i9lwP4S/uZfvikdK5mv9fDbHFAJF+xkfJseXGD6fPujB6kq
         e1HtcUJ5CG7wDwRLN/HAsf6e5wmiR4qMdXAESanvP8DK9WSBuqG1Pk+UdtFgW+43Klkg
         gtkEFx0Q9jU3zUICzYPdHsHj9FFM6w5TD2vXdcgDHv6XzE5OUzef2SLxaWjDwO8WUl7M
         TChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755023531; x=1755628331;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOzgIuE3vZOPdvH25fCuhzEe3nU6ZEctPzGHGhjilCo=;
        b=gHo1+L58sW8GlYcV4uaESAVuYZQG3jylolhV1HtRgZoS9FyFj9nF9QpWAwWAoF6Awe
         UklbOlRO736BP3EZcK85qK9M03FdjpCXF3ZDQkQntYQOFMs7IUAtAwpWrRNULnJDux1o
         SEE5Yj5GINX6OK0LnMjNB1AQpvFArT15S0U80yMiT2wdmiCRq/au5rHZfuOFe+JUS90n
         COtToV0RRHZI5CQTla3NnRfjU96bq6FJZRjAMNQLsFvGy78FkiI9X5ofKlPVwBdG/Ber
         gc4S2FximJi43P+/8Utl78T53zLd2YJ8S60HI1yenD7CIT/SJHrsp0As60poYyjFMUGK
         2FKw==
X-Forwarded-Encrypted: i=1; AJvYcCW/WrKo+ZuNmVGprNsIUlZ7De6ZL1YVeizOAMXuJs0F3cHAfMdhryykr/qNhY1TFr+4iaALN6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWT7JT/2Gt5bpPkqCX/lF98MyHUD3Y0zg5rUVhWXKqiZPz+4QQ
	qLRCGOaA+4pWZw7G9MFD7cOlfod/GUBbgyUvVKz31DeS4jD691gB6xHNRwSBPVcrEao=
X-Gm-Gg: ASbGncsygKth65tKuAX4yYa52ksX/t5ILekyJqztCf9iMfJjhFj1TW5H8dLF4ZZ/HFV
	3p/C3YkEEQrmLTcTjqYzATY2nMm3sJpnq42RcvtjMswSmLN5bTIWDbh3m4VzlbmV+eDZAAjd3w4
	CoVUZtHVSZ0i3x77G+HKa5WVV8o6n6sLze+MPp7Jup14ZGVV59HRxBVARgl+sYaUo05TjpvMpsD
	QsasSYToXaaMcxNmz14a3Q7KNhgSU7ynFsHjJhkLsuDFjLoPRbF8IK9qKxr4SgOfHkmu+9GXNZ7
	eqAbxvt2LzRNniqoENdljzdU8Yy5la2daHAjveMEDpNcDrq+3OXiAut08qV8gZDE5TR2+p+nWXc
	9ZD8D8F4eZVIsdp3CE7lP2Fl0FsNBNulKuF1ofy8s2XzI031lOvPU0eRtfoGGtnMaJqg3B78q
X-Google-Smtp-Source: AGHT+IG2KrHol9nCUAM8optVcWimtea66eF9fSDyxy/8IWeLuAe1+k3ngYybgu7tvMo+ZayxFhdCUg==
X-Received: by 2002:a05:6a00:1943:b0:76c:1c69:111c with SMTP id d2e1a72fcca58-76e20ce6422mr327789b3a.9.1755023531160;
        Tue, 12 Aug 2025 11:32:11 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf5f7sm30033272b3a.88.2025.08.12.11.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:32:10 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:32:08 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v4 0/4] net: ethtool: support including Flow
 Label in the flow hash for RSS
Message-ID: <aJuIqMEZotLPCMLi@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com
References: <20250811234212.580748-1-kuba@kernel.org>
 <aJqNeO36UpQ5KFI-@MacBook-Air.local>
 <20250811183805.087014a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811183805.087014a6@kernel.org>

On Mon, Aug 11, 2025 at 06:38:05PM -0700, Jakub Kicinski wrote:
> On Mon, 11 Aug 2025 17:40:24 -0700 Joe Damato wrote:
> > Do you think that the docs (Documentation/networking/scaling.rst) should be
> > updated to mention this setting and the side effects of using it?
> 
> I like writing docs but this feels a little too complicated to describe
> in a paragraph in scaling.rst. The rest of the content in that file is
> relatively noob-friendly. Dunno..

That's fair; idk what the solution is... just seems like this is really
interesting and useful work. It'd be unfortunate if there was no way (other
than reading the code) for others to learn that it exists, understand what it
does, and possibly use it. But maybe for "complicated" features reading the
code is expected?

