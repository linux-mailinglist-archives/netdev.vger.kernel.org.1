Return-Path: <netdev+bounces-205758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96101B00083
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793493BC5F2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB72D6618;
	Thu, 10 Jul 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeaBNTbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CD2C15B7;
	Thu, 10 Jul 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146861; cv=none; b=dTBI3XHZIOTcW6SQmIthZ5LBQbvxdwMYGwNpEoHOIWzhc2MHDnJkpZcWO2pDOiTc5PYLvxfV+JretAz29nefJ0DMK14APgCNk8MF8VZczYK+AGtegv+KKGSHi+NVYJlKz7O/Cmw3QMPyREUX3lomQ9maHzvM9NzR5+R04TCjGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146861; c=relaxed/simple;
	bh=YclzCq5dgl0eE5mdpw+qGsvA9kPcMfcy+INW0Pn6OCk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=I+Wrs/dHE9RXybAewVMGP8GFHlFQ3RC71zyeXFNPAcXS4Y7BooYAMG6pMQkIn/k2vtd8Z6IjR0gFMRJ7nkyyNDKsARb8Nt3OwFyQrEdXcJfkkwGm/Rj7E8yM/vV/uIyjaVX+eyBd3aRL3tyWL+cy3Xeb15PZCc8X9wwOVbE23AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeaBNTbq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453643020bdso6293235e9.1;
        Thu, 10 Jul 2025 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752146858; x=1752751658; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aR5gXXhx3VKvItg1BxdxP0PttmLiDwY44F0xz6t0vkU=;
        b=IeaBNTbqdhpaOEVBZy2z24GFg77a14/m5533IK2VXGO5oOSkCzl74Rr9/XgrXbQiOQ
         QZh4sN9i1BpLOrlVbgB7SvZZcPtN5NH+u8hnQK1Y8xPY7qtWY9qWVGgFAIbaqS5ZbjUG
         5QL+ZJvmu6EPNZx1uW9JYUmAmCVx2N4ArAtMbiAFRdO8W397/NAS/yGww5EULg8hyonp
         z4sR7AcYNN40Jvc/HzFTHb+GoROLAY6xqI7dOxqRON1ZNqeev4j4drsui0Hyq6Xi+oY6
         5gw+uvVVs4s0zowOBjV76aML7lwpuqOAx/AYVvb6xJ1WLgiFeXr501edeQKZkxlzw00L
         YqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146858; x=1752751658;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR5gXXhx3VKvItg1BxdxP0PttmLiDwY44F0xz6t0vkU=;
        b=E12M3/J10xEngwn7KPbpipl0EXngR5Atp7fOrqUmN+Pb7m0rGY7vCsCU1vw/4JwtjD
         HZLw0vAVsD0iBNNKfLrV99r5vto9U0SF0Ppfq/Vnuld+xQyLyhBBWPq7Cae9iyZPTr6X
         h4iVsJkyPe6otJP/AEr7x/cMk99yXY3w2R/7jT+xmO9weWGsLxQ1d8PBVswbLzTSCiEK
         G61FWdVw8oJznYbmz4SXlBSV7ohDoxUCl1qe59sMwm/QRYlBemKjIU2uiWY63gtbO/84
         2MDmx+iDzYsfG4UBBoa7j2bsFlyhxYiR6TS2/PZPwzeNzbLaecmcS5HS7RABqlEeWF55
         VAdw==
X-Forwarded-Encrypted: i=1; AJvYcCWISgNXOI0kWVIXH3ENB293MSHMinwy4uynh0v5NGph7/yhzpFJK+GgIhzJ5bI0bFZKi5c7BRp4oP3IPYI=@vger.kernel.org, AJvYcCX9Uu3eSX0Qm//OL+3COgqtvXd17A4wqFrnE4HHuOMO0zFJldH8QHvD2i84yBOWuEmMvEj6rCQB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uoSCbYhOsAJv+NGeuP3Twj8rD24Hog9Kl10GNae7TM2GRfop
	6uhHV61f8mMwgfMuyUCTWP7MS9w2QBJXOscjVC2zsINBJtXXLI4ht/0a
X-Gm-Gg: ASbGncuNxB7wmrIizV6wr/RHU4YAnFK0qAlGJFY983tZoICtYkr/0XckrjgvcsGWeVD
	JB3h8ZEVtShq6hLS5K6trdY1Va+VPC7prx9uVl49F/iPGOKkDUXxefrHF2+f268476usX9h5ee3
	4gl7mFImzk8Ul5cQ3Mdq6lRJQ2DMBLzgCktzxsq84/PxgNIU7NC32LUp1kQuOS+/Fq3TuFQrXFP
	qsDJM9a0sIlsHC2rWlgxr55k6YTskFnosbYAhjn7eHjCfPHKsCxxxuOXv8fCvBYJmJClrK/ylvQ
	L9t/lve4NhZrIcSpZCtVM5+hHjfQnEM/QS8+3D5TvVd0DWiJ1JVvaqUeK0EzIZzzWZDPqxbgDJo
	=
X-Google-Smtp-Source: AGHT+IGeZUzCYmlnvQ1gNQzLgpBT+E7yRCR2OB33C3dIxv4RY59Cz2VgZaNawdxcr0x12uYPeJ5XMQ==
X-Received: by 2002:a05:6000:310e:b0:3a5:85cb:e9f3 with SMTP id ffacd0b85a97d-3b5e44e3b34mr5080756f8f.12.1752146857827;
        Thu, 10 Jul 2025 04:27:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a8bc:3071:67a5:abea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1932sm1652558f8f.17.2025.07.10.04.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:27:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  Jonathan Corbet
 <corbet@lwn.net>,  "Akira Yokosawa" <akiyks@gmail.com>,  "Breno Leitao"
 <leitao@debian.org>,  "David S. Miller" <davem@davemloft.net>,  "Eric
 Dumazet" <edumazet@google.com>,  "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>,  "Jan Stancek" <jstancek@redhat.com>,  "Marco
 Elver" <elver@google.com>,  "Paolo Abeni" <pabeni@redhat.com>,  "Randy
 Dunlap" <rdunlap@infradead.org>,  "Ruben Wauters" <rubenru09@aol.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  joel@joelfernandes.org,
  linux-kernel-mentees@lists.linux.dev,  linux-kernel@vger.kernel.org,
  lkmm@lists.linux.dev,  netdev@vger.kernel.org,  peterz@infradead.org,
  stern@rowland.harvard.edu
Subject: Re: [PATCH v9 05/13] docs: sphinx: add a parser for yaml files for
 Netlink specs
In-Reply-To: <eab7fb6b3ab7a29a71c35452478619745e66b621.1752076293.git.mchehab+huawei@kernel.org>
Date: Thu, 10 Jul 2025 09:27:31 +0100
Message-ID: <m24ivk78ng.fsf@gmail.com>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
	<eab7fb6b3ab7a29a71c35452478619745e66b621.1752076293.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Add a simple sphinx.Parser to handle yaml files and add the
> the code to handle Netlink specs. All other yaml files are
> ignored.
>
> The code was written in a way that parsing yaml for different
> subsystems and even for different parts of Netlink are easy.
>
> All it takes to have a different parser is to add an
> import line similar to:
>
> 	from doc_generator import YnlDocGenerator
>
> adding the corresponding parser somewhere at the extension:
>
> 	netlink_parser = YnlDocGenerator()
>
> And then add a logic inside parse() to handle different
> doc outputs, depending on the file location, similar to:
>
>         if "/netlink/specs/" in fname:
>             msg = self.netlink_parser.parse_yaml_file(fname)
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

