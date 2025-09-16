Return-Path: <netdev+bounces-223394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972FCB5900A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E9D3BA5A2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45F28134C;
	Tue, 16 Sep 2025 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc7cXl9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF8F21771B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010150; cv=none; b=eYXCHq8zcn3fklaD9ZOprY4sbH47Qk29POCqY61QaLUbdLtz6Bo8Tl5rel3JmcF8rBcS5MWQHN6eCoppYbHdT70rVrKVtSV+7Ut99zkRpqq3zxsAx97MGRZ3huwpstaweobw1ID/E+7WjYiYI0AcPXoIvxPDW+OM/R6IuuvcbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010150; c=relaxed/simple;
	bh=6j1/MZUxJh4G+iGyaTKwe4KuwbIfGBSsgXqvvtNvsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY4QiNZUpzSHrFEVMSS3e8e24rx5yS/1CsvB6GbQqKy5KOBGMSvpZvp2dTIGgP2eJTF6+SRX6dnH8nd3b5FvoYj8m1FWdM38hrDRc2oF7iNEX8F5CnfsT3+nBJ7OZMZvHDkBkzGwXAt9QmEnF9DkyA53aiJcN1D41gN7NRWORhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc7cXl9l; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b086b4a3f8fso69275766b.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758010147; x=1758614947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxTcFJ7B/8CVO+mwvohENAPIywHUmrIODz4+UjUrUAI=;
        b=Bc7cXl9lw/GPTuO2LTeg9LD4XiuPu1HWsr2X2gW37Fmyzg0odIg8UDJMBVxpgUDA3Y
         R3ETMCRPHenFKUYKD4aUm/JPuXdi0IOmjSgmptkwkV5VjYf0IZ7P7EJFcN1pE/5xpsBL
         Lcb8H/6IOFrZo1EHeDaIa7iGCR3Ke5IaGn3Bh2E8t8ykdffrCImu848PbJ5EYF8VSvMQ
         AodNQlI5FjKg5F/vaNi+INX3vZFT2NCXcHC7sqUe0w9KQAh1QhNyWq+Y6nZT1o6+p8pj
         AyWJfy0U4JHwnexvqdLkt+iGoz/Awzd8ErPOOf0dBTX2T/bNFQIwHzX0qS+hlJGGCHd+
         9dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758010147; x=1758614947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxTcFJ7B/8CVO+mwvohENAPIywHUmrIODz4+UjUrUAI=;
        b=ALCda9io+yyPHacf1cIH17Ob6d23kaMtM6NzNil+eBkccaFdAlqX4ZisLJ5KnHCnK1
         0aIILmJfsn5zx54Fy0Ip/Z8g0IaJ9zjy+JXGHIMZDozCclcFBF926vcwc2xbaScNXJLV
         PyrDgBgl+QVdPY48WGsDiHRwx9ou/9Ev25f2t3N5W20AjIuN+XzXx3VoXB7w/CAzLNEk
         dyVRrBVR4S+DzJfYD6F48DBkqHXESGu1xy+fVN4W8CW0ENizeoibLduNwWaG2JCRux9N
         5gNoctIZSRRDSi8QkGVRYqyi7c4RUPjKW1b4152ITcB2myo5maIjwFLy63svoQC2vEBL
         5Elw==
X-Forwarded-Encrypted: i=1; AJvYcCXi8O2CqMAWHguQC+zWF958rcs6Y4yMZr8uRi/OCQV+lkUVpLPazPELVV3yGZJ/rMuwqAEENpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOoIvodLmVhQIypRg/jUKDzQEDGPGZKD1KqbSfbPkTtxaE+aXI
	sX/ebkSwlGoZhE8CewJLn9RFVg+EKOKOBfP6138Ndcvl9Zc5CcMyV0uv
X-Gm-Gg: ASbGnct8R3BsfeNpw1kfRDYSz0/YFfRDeTnqoTgRU95AIyp4obg0xpsRpDu0XD64SUh
	0J9Nq2VGVOrgdL1o9xifemkg3agPEw5zOAMRyr46zREaRtRVsdJv0mrg+rldWhLxVhEyytLD6XP
	x+7F+P1teYBUHNbPE8zo/fd76fDZRJciiwE/q/KZJzQExWvNSOQwxk4nRcAwozYE8yCq5ojnvVh
	r6U882/Ec1r/d5KrXFiKekPyIHJE62bcZlcClav8Q1ilhZd89Rxc639+yp79ZXEw9fOGsPteYD/
	qaSXaQmiUfSYyqrgx10zL7CPjWSHVoM7jaWPy7pX1AgOxPOeB0kbotLmjIVVwrtFg2b9SXbGqB8
	+pnzZjtg9Hzu0NjE=
X-Google-Smtp-Source: AGHT+IHuMFE/aT0dMon2fGxiiuIGx+KLwh/5BRAIjAdyNSjrXTrMl1Cvc4UwA/Fkrwuo+9ZbsHOeEw==
X-Received: by 2002:a17:907:3f95:b0:b04:36bb:54e with SMTP id a640c23a62f3a-b07c353ff38mr859250366b.1.1758010146707;
        Tue, 16 Sep 2025 01:09:06 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b33478e4sm1093258766b.96.2025.09.16.01.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:09:06 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:09:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Message-ID: <20250916080903.24vbpv7hevhrzl4g@skbuf>
References: <aMgPN6W5Js5ZrL5n@shell.armlinux.org.uk>
 <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uy8uh-00000005cFT-40x8@rmk-PC.armlinux.org.uk>

On Mon, Sep 15, 2025 at 02:06:35PM +0100, Russell King (Oracle) wrote:
> Since mv88e6xxx_hwtstamp_work() is defined in hwtstamp.c, its
> prototype should be in hwtstamp.h, so move it there.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

This leaves the shim definition (for when CONFIG_NET_DSA_MV88E6XXX_PTP
is not defined) in ptp.h. It creates an inconsistency and potential
problem - the same header should provide all definitions of the same
function.

