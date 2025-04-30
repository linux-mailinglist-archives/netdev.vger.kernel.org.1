Return-Path: <netdev+bounces-187101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4656AA4F8A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD34980BB0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BA2580F8;
	Wed, 30 Apr 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTemXNe+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCC2609CB
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025381; cv=none; b=Qn7Yt7R9fkJvkHx3Pf1DhIymdxcqXyunULT6j9TP5tHYJ8pTRFCMYQDBe8gF0hXbPutmQEjrAnCU+wG6RrHXFH+H8u/2CAWWxRamga1wC+9tllzGN+k6x13WF30dC0r4AS6RwcNtId2AG+ZQ3KlvjBZIBYXZkLIuDdfU5KZSaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025381; c=relaxed/simple;
	bh=BqW69G1tN1CMAfKQejEIgipOoujqECMI00TeboTfmNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYNGo6NQHmp68zBpxWnYKwv+cqobMLNBsmsGX8pY28iIncWJLBfS7JMVWMOOrNiKHMW6K5fp6Ll7H2CW9eFoRmtPScvJWLEwA0eOQoDgWDGZpt4gbGj2rPo6EiOM0AeJLENLIBt8ls2spnGaq0TYAf6Z8cgS6TWk0JsSmwJ8kLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTemXNe+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac289147833so48473066b.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746025376; x=1746630176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqW69G1tN1CMAfKQejEIgipOoujqECMI00TeboTfmNg=;
        b=cTemXNe+eOi7SB3kG2gz7MKaGouG+zMyLVKFSzpPcFADu0X5k3zVqedSKwYdgbMPkh
         5woUt4ywVagCc2UGpwIlF9dc6BfX5Cm1bbXfOEdyBaM+yMBAjl67gwdRotnzse8jdq7w
         OD4bmjppj4Xm5/L7BcnkGmfoNebvmAfB3PxC9aMXmH05arwhXg30hQs+CTSgP/y/rzcZ
         3q6XYO6nn8RM6k3LGdwnwWCESuAzmS0nUvFu0Fm1GsRhwRZgnHwnmJqXcVc9cwatcGb+
         fr6pmx2b5zsUJQpexMzfbGYTXkHwwZKE8jw+S3QbpVeOY+QQn/TqnFWJYOvyn8Er4x8Q
         g9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746025376; x=1746630176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqW69G1tN1CMAfKQejEIgipOoujqECMI00TeboTfmNg=;
        b=qmCIZw7jviqOZ+eMl3GYDVbCtILcxHDJA10fKuSCYPJyN3DY7V0uymaLDJ1H7h4PHm
         ykqstvJLY/g8Anb7kHsJzf4/2c10osESnTknKUGdfv+XjxJtHLNZ6EAgr2WHTql72ue9
         j57+uG/eTO920ymP74hqsAqg3h8h7JbrDihw3WxL2F+IDKB/w8bItuBs7KXSy0yyM1k5
         Ijlv3C85z5iYGWbDz60rmtWOmEZtnF74DzEl2LoIvtvaLHv8Xq1tic9KkVLvwDJX9nqF
         5Da2R2xLqa71KeLoDary+Kntdgkbzi2IpqW9N9nNlEwzrwSsLrtCZXg5A3/l8DoQiSXe
         pknw==
X-Forwarded-Encrypted: i=1; AJvYcCUp+KLkFptxRO9yW384/5CGRe5wKCek28ljb41ZVWp8nEHsSeXl/XGBYOjCMFhIripI5gjD3J4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4BIzaVXyeAZPCT4HDepA8RNqJAiqjk0owbTw6QCmN1OSXfCY
	tyB1kPRcb9v+8O47WK2zDnCcI7YYxY/k/+/Ia1rWkLYD3iZKKPgm
X-Gm-Gg: ASbGncsJnZNME6MHdCB+xzPIK8YJZrvlFgAZS8LajqMHWJpJdnTQ9KEYmXYCRkiGzmE
	rAAygrnUklnj1iuHYHoVuxAiMYPxxgoUe07/mnvqI7PfIo0RLF6KlF8Y734qNIYobOjWr7oDQ0g
	cb/ykwoJX7RuBhw4d2fpWz5rUhn/yw/c+WnnLJ6bhJSEkL1lj4xFC9/XXwwJ2ckFZo9IfA9XyyP
	dR4qyshRxgrR1AY7fMfjoXDR7eTA5E3ICGxCEzEM7+iFDRiM8aRgbZqOnytqEfJLQez2/eznP2G
	kGkd8mpPKtxgZlPEbAfiry1csFJYE2oXOQ==
X-Google-Smtp-Source: AGHT+IEPDmVKiYfgCrqHSFi/kLnJfPgSZEpwIRlJBU7+dYKEXtavzY0FiL1krpiP7f6t0hxIuxu0EA==
X-Received: by 2002:a17:907:c23:b0:ac2:d0e6:2b99 with SMTP id a640c23a62f3a-acee2404095mr331743066b.36.1746025376304;
        Wed, 30 Apr 2025 08:02:56 -0700 (PDT)
Received: from eldamar.lan ([2a03:2267:2:0:f6dc:4d65:9edb:6ecf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec123a3easm338844966b.147.2025.04.30.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 08:02:55 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id DCBDFBE2DE0; Wed, 30 Apr 2025 17:02:53 +0200 (CEST)
Date: Wed, 30 Apr 2025 17:02:53 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: AsciiWolf <mail@asciiwolf.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org,
	Robert Scheck <fedora@robert-scheck.de>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <aBI7nWLq32_mHMRT@eldamar.lan>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
 <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
 <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
 <aAo8q1X882NYUHmk@eldamar.lan>
 <i6bv6u7bepyqueeagzcpkzonicgupqk47wijpynz24mylvumzq@td444peudd2u>
 <aAvknd6dv1haJl3A@eldamar.lan>
 <utlmo4lzclx5u3w3a7kp6jrpsv2zkjobzxnb6meusclp3dxv6j@43t6mqbglfqb>
 <aBI3GZ_yLdfkZuTP@eldamar.lan>
 <CAB-mu-QfzzZX8x-rPsras9r7jA2vMSpNqimV0h-OBOaa-z2tuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB-mu-QfzzZX8x-rPsras9r7jA2vMSpNqimV0h-OBOaa-z2tuQ@mail.gmail.com>

Hi,

On Wed, Apr 30, 2025 at 04:46:28PM +0200, AsciiWolf wrote:
> GPL is not a valid AppStream metadata license. See the official spec:
> https://freedesktop.org/software/appstream/docs/chap-Metadata.html#tag-metadata_license

Yes, you are right, so nothing to change here.

Regards,
Salvatore

