Return-Path: <netdev+bounces-184153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2EA9381F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 15:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAED19E7045
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF984A3E;
	Fri, 18 Apr 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niBVMkKE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B478F3B;
	Fri, 18 Apr 2025 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984374; cv=none; b=grcw6UbFOA9igXgd8/MztWzr272VpjtuC7Ndvnk3quVi5kLKiu7xxl3RnBryCr2LmxpctfVR70E8sXBth40YQ8YOljbAlLKpsfpE6UA50Uk8XW0k6x3jaI6y7/ekFS8VZweCvMGrp4Fre38jjapdK3cdS5PRycV54Nn4hSPhnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984374; c=relaxed/simple;
	bh=CuBgNv5cd1S2PD2hevcSRahDNpP8CA3ZoLvuCSdO+No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKJd3n6tloe7OA27kjuv5KCdVLn6O7bCMAWWqYGdLggPKZwZ5DuoKwE86pn3D+Iec6lJJZanoP/3xqs6Y3rKTywV67stex6DKmSV33tsWBAreSjlf6ujy8a+jtjGMMnhdYaUv4qDM7YRYVOZocobeEJguqBGyPLKhKD98nLCK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niBVMkKE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3f58b9156so18602566b.1;
        Fri, 18 Apr 2025 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744984371; x=1745589171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuBgNv5cd1S2PD2hevcSRahDNpP8CA3ZoLvuCSdO+No=;
        b=niBVMkKEuUOkdEoJnBkUjNNVWgkmvPuS9htT77mzGy0tGsKyTPGkXlECGIRIs8AsO/
         W4qVCm1QVOlvyImXwi1V7alLzK0J9mrpWGrK62Q3UvVM0m01oROmBH+Hgk6EJz444wGZ
         aBknhOnaXAoG19m1HZsLA+X/Iur+mBh7GWB66wRUmoZjoXzeM7+AV/5bhuN0L8zHsSQp
         Cgr/dTomVDPRJZ0Vaq9FwEobJ1Fscki6vozakNYnH42xHP4OpOLcfjD5jiPJZsV8izE6
         87A0y5qLEOk9Y9IAs4bV69rxhkGxX4p7NOwAN1f3U/8gwjFi0CLr6Mqk0KaiHwfJ2+89
         ywqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984371; x=1745589171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuBgNv5cd1S2PD2hevcSRahDNpP8CA3ZoLvuCSdO+No=;
        b=TuCumcnd6Yxa4Qd43VplorbgsZvB98AaHYJlAM3k5rXO9sPx08A4GSOb/x3gJfXmMA
         jLq51yKw2S4V0o+2MLXnFUdWTj0ky7IrXBZPN+7XjYJcbw/Y6x9PqYIUh1b7OnpEM5cS
         GpufxzR0xaau6G9HFJuSGvqhHZ9nYXsmNZ6E127712dl5hFzMi2zaqeFGOZ4J+bSpL6n
         iA8q9Y19KE/a7l1bRwa2CTkjZ/wLEPE2qo8lrTPcwzOf+tme4ud6AgS51YF24oDQQp3J
         PY4YO0rVkXWpWCj3X+FL9ebYEWW0UZlGSRS4kFoNTfcls4h9QCGeSj2DoZxFljx7yH1P
         65MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6Nn3wdvZnCGl2aw62/zAPrxr8ay9Qm23lIjLzfZ509hSmTijzaWwuVAfjgqemQBYLu7LGZgK0Arh0yb8=@vger.kernel.org, AJvYcCWpwcauKepKfPt/yQPWYIvlcNXOSUauKs1JDAR1jz8NbWWNeL3QCTslYUR2xi9N8zMqMcoXnETH@vger.kernel.org
X-Gm-Message-State: AOJu0YygPoJq72FCeQliqdZT6TZxKoz/1TiMFI2RURb+FPiZ3M/1l9AT
	XaCFWtYP++KYZWq6ZgAR+hKNS38hrv8LIyzcAJ7DQH31ha0zA+C4
X-Gm-Gg: ASbGncsi11pxH8Zx/8WAN3cGdseBBdv9SmQMKoEH5mYI+MXHqWSjwwZpA16Is0i5Y2k
	Vd35E5jApWiTX0bwR5s4qkqbdtjEBjv3OSX9maJdG1Lqmnsa/EIQnenMtKZf0dPcXB68WiGxiQ7
	2hMwAJg7yPsP/iY3xpS+Sx7w5rtY+vzQwBYsAZUJyNz1f83wNX3Cuk6x6+r9TDMigcEdBeskjbz
	Rd5BWTHtvqXJgH4puvX9KMlampAwVoXxTzAb/7uuKsJS419nYSx86GcMJ3mM7jITb6CrIvINJOG
	O85ZzqJ3FYSP9tz/SBLPZEW57/lb
X-Google-Smtp-Source: AGHT+IFVtlQMaZys0yRiOygdgzqKHFtvYUnzaYsTx8NK1/CznrSsNWU+sPquLkREls3wzbKnT9aYMw==
X-Received: by 2002:a17:907:7f0d:b0:acb:583:c63a with SMTP id a640c23a62f3a-acb74dd060cmr67927566b.15.1744984371062;
        Fri, 18 Apr 2025 06:52:51 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec0bedbsm124885266b.16.2025.04.18.06.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:52:50 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:52:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 net-next 02/14] net: enetc: add command BD ring
 support for i.MX95 ENETC
Message-ID: <20250418135247.kf3syqrv3lznmcbf@skbuf>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-3-wei.fang@nxp.com>
 <20250411095752.3072696-3-wei.fang@nxp.com>
 <20250418132511.azibvntwzh6odqvx@skbuf>
 <PAXPR04MB85105C88656FA179985C8F0D88BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85105C88656FA179985C8F0D88BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Fri, Apr 18, 2025 at 01:49:25PM +0000, Wei Fang wrote:
> Do we need to retain cbdr_size in struct ntmp_user? Or just remove it in
> next version?

It seems redundant with cbdr->bd_num, so yes, please remove it.

