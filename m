Return-Path: <netdev+bounces-58204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C306815872
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C891F241C1
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE912E43;
	Sat, 16 Dec 2023 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFWy/Lbe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D18EA0
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6da52f16427so937440a34.0
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 00:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702716274; x=1703321074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kG1jsDnI3QzTEHCezvQioxIOR0SJByJRInQGAjCFxaY=;
        b=EFWy/LbeBQuBC8z21JHnCMvDKg2iVPfCPBXfMV+Ch5GNIB7h74CE2LbdF9QivdEEaq
         6s7uqZC+ZpA36/Xwb5ZkRgLFjgdIpmfc+zVS9yFdxbvEs9k8ph1Sq1/mBYrZWOOKT2zl
         7e7KESBrhHAJegXHJ0a9FtFDMPbkirWOS842583AhNy4/ikQLLvXBf+aBbrEbCxmejg3
         kPMOpT5ali2dhWYqKzgYMMCJaxAuQEBSDRZxn5clMm1SzPAWMOPlubnpMQ8uIwDK5v+s
         yCFg9p2TQodGmdsq2+ROzbiXXjpz/Cr7Epz4onRi7eMmuN874e2BM/rVnFjlLESSsJkt
         F7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702716274; x=1703321074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG1jsDnI3QzTEHCezvQioxIOR0SJByJRInQGAjCFxaY=;
        b=A6jJBbPzcYteBtxnLMZv63gQpi0GOHxEFRGq6VuJpRp5AzH95/UOx3p/WMrhX6HFYp
         CiNo7TCoUH84tNNkT/xo7IUhphBDWv/RtFHzZQlBaY7jVJmV9w6Xg0P+cLFA3I5FRthg
         HtHiaEns0F6XRKqucKbh5c4xG2A/9JDIBBmXL97cyGm0TMv2djAFY2q+JDnCji2O8R9X
         i27nBJIdD7YJ+WLLS7e3fKVxGkZyq5W5wsXaeiipvOlPUXDxBfLzsN5ufBNTZ1OS4NQd
         2kMd7cwlUcvO0ritgL7+N9pCTzOAx0JoCgpEtY8RfHO0ZOZNLCqEQJ9Rry58qEzD/nDc
         Y6bw==
X-Gm-Message-State: AOJu0Ywd/fiOsIfTBlbZw3PR1VY+44r4rJjvotCcXOUOkTafZxyOaWhb
	Qncq3LJADVCW2keOwp9ydyoVZxeCmF6Cf94E
X-Google-Smtp-Source: AGHT+IFPIVf2ivWS33zGXXyL94Qq0T++5XxKOac0L65NEiQD9CGmRywh0amW7baczCs0wf4YHK+FxA==
X-Received: by 2002:a05:6830:16d3:b0:6d8:68ef:907d with SMTP id l19-20020a05683016d300b006d868ef907dmr13475903otr.7.1702716274617;
        Sat, 16 Dec 2023 00:44:34 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b006cde2090154sm14687875pff.218.2023.12.16.00.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 00:44:34 -0800 (PST)
Date: Sat, 16 Dec 2023 16:44:30 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] tools: ynl-gen: support using defines in
 checks
Message-ID: <ZX1jbgQ3lgQtkF02@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
 <20231215035009.498049-3-liuhangbin@gmail.com>
 <20231215180824.0d297124@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215180824.0d297124@kernel.org>

On Fri, Dec 15, 2023 at 06:08:24PM -0800, Jakub Kicinski wrote:
> On Fri, 15 Dec 2023 11:50:08 +0800 Hangbin Liu wrote:
> > -    pattern: ^[0-9A-Za-z_]+( - 1)?$
> > +    pattern: ^[0-9A-Za-z_-]+( - 1)?$
> 
> Why the '-' ? Could you add an example of the define you're trying to
> match to the commit message?
For team driver, there is a define like:

#define TEAM_STRING_MAX_LEN 32

So I'd like to define it in yaml like:

definitions:
  -
    name: string-max-len
    type: const
    value: 32

And use it in the attribute-sets like

attribute-sets:
  -
    name: attr-option
    name-prefix: team-attr-option-
    attributes:
      -
        name: unspec
        type: unused
        value: 0
      -
        name: name
        type: string
        checks:
          len: string-max-len

With this patch it will be converted to

[TEAM_ATTR_OPTION_NAME] = { .type = NLA_STRING, .len = TEAM_STRING_MAX_LEN, }

Thanks
Hangbin

