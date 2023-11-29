Return-Path: <netdev+bounces-52029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B57FCFF0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9752821A9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB1101D4;
	Wed, 29 Nov 2023 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCyIvpmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B9E1
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:34:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso27748965ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701243288; x=1701848088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FblQA5PGCEPuckIi8oE+dkWVllgH7vN+3nYQ16423MQ=;
        b=WCyIvpmKVedFCdb2CuKGYoavdb07l9oPalmF/nku/sO11y60TXWefkbcnI5M1eRuV8
         3KDeXV8EpB9Ls8hR4NSBhkK1csALZcyWw5YLdYuhACLVJdhli+FCCh9Xo8gh1jp0LEZ9
         CCI99FonnxeIGVBOi5Rf6HPMEYru4OPbu7FEde/iYmg5vRYAzpSCEkCIVySzL3i2r6Gm
         ziLlul4EzijIi/mgVD322nsPWkgAbuLckTmAL9hiL2unDq1Z2S9P1sCgzihTMkFRnGKy
         fkcC96HuhhEviASiaCo1iUZV/K9DB5WRDOmHQoCppo61dGETUcXLODXmHkUI3l7HqLcr
         lXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243288; x=1701848088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FblQA5PGCEPuckIi8oE+dkWVllgH7vN+3nYQ16423MQ=;
        b=gr7M/YvjFC0NYdjeuh2XXG5WuW3zxvP1oWCEFVnLLYbSOrIkyte7dztSf6h1vAnopi
         xMplWUf7AGUoSPeIQwKSz61R6u1RO7SrqjHorLP9yR3WwptoNfedm/r1x/Bbwh4LwU29
         d7qmEWSCCUI9/oQUsto22ctcqieamY14j+Mw2UCbkLqM0VdW3Ovqpf+FcLrIPnQJt1mg
         UhoIJEUdecgltL118QhU/nbjBVdm3QQphe2UXpXvriOSz4b6O9Mn4ndD3YdrHOXrLXXN
         pFQLj4xJTWUYbGBw4e/v90fhxcjigZYGOj2BXbVHXh8I8d7xAsEK3BjDB6UpYUNCF5Yg
         nAwA==
X-Gm-Message-State: AOJu0Yz0UT2JxTVLvX8IFVMZa0Ohjew/7tI9LBApaPvnfVE9YW71/wVf
	kPVNKMWsN+aYKBVRIo8oHsY=
X-Google-Smtp-Source: AGHT+IE23VXLzuMrOR7gWSsSEMJJ8GWhVJ1jElxFsTUjCp3fjDKInjcu0fEYRPbYTIVOD2aHoTaFCw==
X-Received: by 2002:a17:903:11c8:b0:1cc:511d:eb43 with SMTP id q8-20020a17090311c800b001cc511deb43mr22770959plh.61.1701243287976;
        Tue, 28 Nov 2023 23:34:47 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902b48b00b001cff9cd5129sm2680110plr.298.2023.11.28.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:34:47 -0800 (PST)
Date: Wed, 29 Nov 2023 15:34:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 01/10] docs: bridge: update doc format to rst
Message-ID: <ZWbpkTf4qyAgTAGy@Laptop-X1>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-2-liuhangbin@gmail.com>
 <20231128144609.08b4275b@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128144609.08b4275b@hermes.local>

On Tue, Nov 28, 2023 at 02:46:09PM -0800, Stephen Hemminger wrote:
> On Tue, 28 Nov 2023 16:49:34 +0800
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > The current bridge kernel doc is too old. It only pointed to the
> > linuxfoundation wiki page which lacks of the new features.
> > 
> > Here let's start the new bridge document and put all the bridge info
> > so new developers and users could catch up the last bridge status soon.
> > 
> > In this patch, Convert the doc to rst format. Add bridge brief introduction,
> > FAQ and contact info.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> Should also reference and borrow definitions from the IEEE 802.1D standard.

Hi Stephen,

Do you mean to use the definitions from the IEEE 802.1D in the doc?

Something like:

The IEEE 802.1D standard defines the operation of bridges in computer networks.
A bridge, in the context of this standard, is a device that connects two or more
network segments and operates at the data link layer (Layer 2) of the OSI
(Open Systems Interconnection) model. The purpose of a bridge is to filter and
forward frames between different segments based on the destination MAC
(Media Access Control) address.

Thanks
Hangbin

