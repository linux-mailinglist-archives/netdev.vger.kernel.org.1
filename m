Return-Path: <netdev+bounces-59450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F881ADE1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB94282E32
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE866103;
	Thu, 21 Dec 2023 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pH0OgXZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D125676
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28be52a85b9so219483a91.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131665; x=1703736465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vom0wzjXJ2Tu19TEdjQx0fFY+nDNJdz8mMULeYRLJnk=;
        b=pH0OgXZFWQyHXt864pyqyhEoYgijbPUSjj5TMzcNh6mzzXGkfMJRfLfnOvXJ8QgG6i
         TPDGqrptmje7Vf82F2B3bXLct3MGoAVduESMkF+6GQbWI666dHIA0CqqY5bz8MTw6aO+
         EtcGoj8sPhWXaSNT9ahnOPiaTV6oOuz5J/HTCpTF2uZcjeDymyhdp6y7wWUgDwWHV9xr
         FYYFWwNVuUEwgvuPE8rOjCx2AbG0I7W5PQx78wHe+CXK7sn6bHBvI5FU0Mu0J5jX30N1
         lM0rCUhP+ac9IUcoWmkKSSynIp+liUFbix60aDo88aigRozIttbieXgXfiU8rmm3Aoti
         C5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131665; x=1703736465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vom0wzjXJ2Tu19TEdjQx0fFY+nDNJdz8mMULeYRLJnk=;
        b=TgLM0qPpiIwbTlFXud0rTWqQpyf83IrJNdgHd8rzhY58PBvzipz4jIiwYJgIm/WcLP
         gn+PMIqIHYdNfGTVTPRxsEScl4sN9cmyvEX/Joc+lkw3k/Jy/12At7XjQ/H+DoBNkytJ
         +EAtNtEGBoRLv4bQf9/BR+7U4NER7eVQ7UK/eXhjb90WMe6Szs3o8y26TEFFF9s9LMx5
         HcNW0B9V8QcJM0+v51q2sNe/lbqraCSokiu78q8EVCtGeiVgGfMO+nWlTZ3NcwcJq1eX
         jQTuxOeOuKJHNxPk/ff6KIaOH9ygMWhfXPrpv+009T10gflXqKaLZPU2XuOcmkhbcnEs
         E77w==
X-Gm-Message-State: AOJu0YzC2QJnFEKPwUQ773KS4EJnoR7Z7OTu9Eola5YZzl/4Oa7lYPeR
	g9wzQCgBkwIEHS9JvXqOIJ1fHA==
X-Google-Smtp-Source: AGHT+IEwX2YCtLdB7RMud++v0X40UcjYhyak35ZyBBl0xcHUFzB7zRu4KM32sks8Z9oT2OazHYLFbg==
X-Received: by 2002:a05:6a21:a584:b0:195:226:f6dc with SMTP id gd4-20020a056a21a58400b001950226f6dcmr186214pzc.87.1703131665446;
        Wed, 20 Dec 2023 20:07:45 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001d3ebfb2006sm512288plh.203.2023.12.20.20.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:07:45 -0800 (PST)
Date: Wed, 20 Dec 2023 20:07:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 10/20] bridge: vni: Guard close_vni_port()
 call
Message-ID: <20231220200743.0769e706@hermes.local>
In-Reply-To: <20231211140732.11475-11-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-11-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:22 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

>  	print_string(PRINT_FP, NULL, "%s", _SL_);

In same place.
That could just be print_nl()

