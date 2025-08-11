Return-Path: <netdev+bounces-212495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7437B2108A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4870018A3659
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89662E3B08;
	Mon, 11 Aug 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKwYi4+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2A1A9F81;
	Mon, 11 Aug 2025 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926369; cv=none; b=TwTdIOU/E6pY12Z8BjuOTLOYgeAXgH6mi4PuSaARWqOJOKlxNOY57V8gQozTPI2XPYzBOdVveaAUuhaOfDRuJat/fnhHgvnhw7F/Q70GVoC1VjHy1By+m3AH9JkjGeEU6xaqGpus9xGhn9ycUmL4oGMz2qHLN6SJkfzgt1YD55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926369; c=relaxed/simple;
	bh=Z25OrWvv8TxyNjzsQlciP+Z+msCssbxdYitM55qzYnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4Du9eaCz2+TftBx6zBZbE0iR2AoqY8Ec/t0BWHvOVfBhM+QyEz4Ng+x2DUrAURWB6eBoeoNd6Q+QSxjZYNqSL8Y61scWGgxZYXOcXYuZOUC//ACiVERi4BiY30RDHd1rB7RaalKE3JFF5K3nOwVotA+InjD99pYCmYpwRIBI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKwYi4+G; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7813c7858so446686f8f.2;
        Mon, 11 Aug 2025 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754926366; x=1755531166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vK+hERJZCtlKbRi+DIfKZw+ktYsRe+Svmw9vP2DQpoE=;
        b=WKwYi4+GYJ9zjfQzrAhXve0gejfJMYPBEcEIUDkIXSdILfaf4xHuCwo38jfyrBE9xu
         Ib/DdEu5H0X5RUa0ABjBxOinhscg0IC4mKE0V5xoeb6itCYtaDRUIHtLUH82o+YqIPeH
         0wDO6aUD2MC0aM8fAt5iars43okFPEgBxQVMp30dh5/RsOT5F0XsFkZBqX12y0ZFk1cY
         nb8jckoXwG8KytQqNdkT1q8W8QfVxFenkdgAly97+Dq8uBy2wKLk/HLsYkMsVvSNDNaD
         TXvFG68E6pi2S4JtMRlQPf6MYqbjB4NlnpH2DQf+tgQ80m07oDifSDMli5feJ9v88Q04
         SXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926366; x=1755531166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK+hERJZCtlKbRi+DIfKZw+ktYsRe+Svmw9vP2DQpoE=;
        b=m1mr2IXhmVd+mSvEldyOAfVa54Lng5TMA/aX4sq6LWEoR/iajZ3G/0Cqu7pHemfhKE
         oOTiEAeoB+ZB+HxIZ18F4c/xQ1AVMkN3RILpHqIWTW0CjB3Ne+QW0pIr/o2hPLW9HWL+
         oFpHFEmmzMbW4JhuDk7oatc9KCKq2yFrtEq5TSATRXJ6xU9k92cPY5zGgFDHc6mdaIFN
         ywkJqYrpUrpZB0ecVRGkqG2VYfcoSR8pfNcl54tlD1up2lA4E3DgaLW5vo4H9lky+v4W
         pVGh35r+3jwwZPWUSfK5fgHTwoRI9Kwi/7vvE58bz4ufsaP6eebep5LhLs0LEVtuR3gG
         uoYg==
X-Forwarded-Encrypted: i=1; AJvYcCVwgC9vaR3IfluqnBzjj6PZDwucyVMUtlkcM4q1i5vjHcnYI0Ztx7TqybwCYs0Ekuv+ri4WjEa4QaGqXOE=@vger.kernel.org, AJvYcCX91VE09jYHXWs9BfZK2CGqO0jQiTQJrHU2AlYx+bKu4LyCXPJWt6RSV32MZc35fEz/I3Iy0duB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oT9EZ8z8Gz77VhDp0maksdlDb8j5e3hY9nlRQ0yfuSJfpjVf
	qgDp9UEkjNJPJknoI/EQ2QjXXHMV2qbNjwu8gONjlODagHqNAHaQV8RR
X-Gm-Gg: ASbGncs24MFvvxvBe1odcS1MJLolHKtbIoh3tVMWotxXcM2yuT2zK97kjs30hBxUHEv
	ClT5M2gniaRHyEOhf7HVH6L8Zi8+lKyzKIFB89KDEGibvo+lTjm0oPpt+IyhV7ryMWaQ0vD+apO
	eQjmHxvVQDbTUGemPwTn6usvaMWGMjGmAKc0CIyeYOhPz911E6CvB19kp2W0TJCHOQKXSm36Gdm
	2N+Nt4Xmb0VaUljWCRtYUM5j3M/ST/Tr7delMw+Afd2jhZycKC18ROV4HRFlrLe8quNb2iOn0kY
	22yBDPFkSImKsBkMlw/Bmysg9p8+1zhW443S0A1ZIb8aEMa+cnu0WURA3G9jtPySqE8fuEb7UIG
	0DBv6ecexE8FmgNgPimgNDTZ7
X-Google-Smtp-Source: AGHT+IHageYoFNuco2UeOcWT58/oUBtKXSXGqmCtqkN2yio+TlHR2hz6lwjLxrQiHPxD0ZnOd6XulA==
X-Received: by 2002:a05:6000:26c9:b0:3b7:8f9a:2e2c with SMTP id ffacd0b85a97d-3b90683a788mr2274198f8f.6.1754926365998;
        Mon, 11 Aug 2025 08:32:45 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:15ff:6865:527:c8f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586a011sm280943165e9.19.2025.08.11.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:32:45 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:32:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH/RFC net] net: dsa: lantiq_gswip: honor dsa_db passed to
 port_fdb_{add,del}
Message-ID: <20250811153242.znhebimdzc2erznt@skbuf>
References: <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <aJfNMLNoi1VOsPrN@pidgin.makrotopia.org>
 <20250810130637.aa5bjkmpeg4uylnu@skbuf>
 <aJixPn_7gYd1o69V@pidgin.makrotopia.org>
 <20250810163229.otapw4mhtv7e35jp@skbuf>
 <aJjO3wIbjzJYsS2o@pidgin.makrotopia.org>
 <20250810210200.6n3xguqi5ukbybm2@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810210200.6n3xguqi5ukbybm2@skbuf>

Hi Daniel,

On Mon, Aug 11, 2025 at 12:02:00AM +0300, Vladimir Oltean wrote:
> I suggest tools/testing/selftests/net/forwarding/local_termination.sh
> once dsa_switch_supports_uc_filtering() returns true.

Since you're working with the lantiq_gswip driver which receives
relatively few patches...

I would like to submit this patch to remove the legacy behavior:

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6b8a5101b0e7..7e11f198ff2b 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -886,8 +886,6 @@ static int gswip_setup(struct dsa_switch *ds)

 	ds->mtu_enforcement_ingress = true;

-	ds->configure_vlan_while_not_filtering = false;
-
 	return 0;
 }

however I'm sure that the driver will break, so I have more, in an
attempt to avoid that :)

Would you please look at the patches I've prepared on this branch and
reviewing with extra info you might have / giving them a test, one by one?
I was only able to compile-test them. I also lack proper documentation
(which I'm sure you lack too), I only saw the "developer resources" from
Martin Blumenstingl's Github (which lack actual PCE register descriptions)
https://github.com/xdarklight/ltq-upstream-status
and the Maxlinear PRPLOS code at
https://github.com/maxlinear/linux/tree/UPDK_9.1.90/drivers/net/datapath/gswip/switchcore/src
(which I think is what you were also referencing)

The branch over net-next is here:
https://github.com/vladimiroltean/linux/commits/lantiq-gswip/

Thanks!

