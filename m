Return-Path: <netdev+bounces-52166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A07FDAD7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFC81F20F62
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14E63717A;
	Wed, 29 Nov 2023 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="urKS36a1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C0A3
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:10:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so30337035ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701270653; x=1701875453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnUSoPIUibKKwgvJOIq0s/PBEPwqt8TABHapEacirgA=;
        b=urKS36a1lkQV7gCvKW8b+qxbu8HSF/xUJDw4HXwfO1Nq9LyS2fT3mPZfZcfFOAwh3Q
         an8dfD27oHKlZkvs5WbUSgDlIic8mNdC1JUSYsZRqwRRq2TPoyYKc53TzMWk9q5egL5Z
         9G4hJ9+8awmCNjIb3Bk6oVW5+o3FuZmq23UAmAjzen51DXZgI+vSnbCx/qJVrQX1zAhp
         YyUpHT4YQBvg4bEa3xmp5Gm3L4Dg2/LcOS6zV0LXuWvBxD1RCEmyeRaiOJXBOyoGGa2w
         j4izj/1sc6ZskOus4Iv+fkPzO2tapERcyIdOYJ+NPBN2Xab0choUaPyMtNDvjvb6DrBJ
         jd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270653; x=1701875453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnUSoPIUibKKwgvJOIq0s/PBEPwqt8TABHapEacirgA=;
        b=chdr349A74sIdD/EOZDeoSS9Sl8o7eMP3BIMrKalepTu0eqo4JmiZb47YDNST2sMe4
         fKoLIhCJPuhXjfpuIPLfnIIvNzX1qRD/ieuyElIcpyTDoT1rVMQqw/REVgW7SpKOWrV/
         8P8aBvT0ICx5/K4x67S0+Q1BEC47Q7UwsRrTUeRO3RF8dRMDfLNQlZ1Rs/EZQjz/Dvts
         WdfGtjMqvNECcX1M/153z+ooUaz5ShPsQ/02/SP+lR67F2iNRdSiDQpvMc7Li5T4aJrG
         AK6GlE+NppRnvW5rdLfdAXI36k0brrlMKkZCLMjfA4QhGWdMS63oLMx6XSycUqUbnlLn
         oF9w==
X-Gm-Message-State: AOJu0YzWo1TZHRfZOFgoDOF+DuGV0tv/9lY7eUkg2u+CL3FMwG/q8fZw
	oUpqxv+sNxA2U/llVhsht3wOUQ==
X-Google-Smtp-Source: AGHT+IGETGYlv/a3i1DAI2w5BMhKfggkFefYebWn6m+4ysNuRzwCXUdQRspEVDwVNDkdisYIwwFZ+A==
X-Received: by 2002:a17:902:f54a:b0:1cf:e012:462c with SMTP id h10-20020a170902f54a00b001cfe012462cmr9805270plf.66.1701270653292;
        Wed, 29 Nov 2023 07:10:53 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id mm24-20020a17090b359800b00262eb0d141esm1477394pjb.28.2023.11.29.07.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:10:53 -0800 (PST)
Date: Wed, 29 Nov 2023 07:10:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa
 Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld
 <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 05/10] docs: bridge: add STP doc
Message-ID: <20231129071051.195f5767@hermes.local>
In-Reply-To: <ZWbrnK9VKczMrCMb@Laptop-X1>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
	<20231128084943.637091-6-liuhangbin@gmail.com>
	<20231128144840.5d3ced05@hermes.local>
	<ZWbrnK9VKczMrCMb@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 15:43:24 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Tue, Nov 28, 2023 at 02:48:40PM -0800, Stephen Hemminger wrote:
> > On Tue, 28 Nov 2023 16:49:38 +0800
> > Hangbin Liu <liuhangbin@gmail.com> wrote:
> >   
> > > +STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
> > > +model. It was originally developed as IEEE 802.1D and has since evolved into
> > > +multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
> > > +`Multiple Spanning Tree Protocol (MSTP)
> > > +<https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/>`_.
> > > +  
> 
> The STP was originally developed as IEEE 802.1D. So how about keep this part,
> 
> > 
> > Last time I checked, IEEE folded RSTP into the standard in 2004.
> > https://en.wikipedia.org/wiki/IEEE_802.1D  
> 
> and add a new paragraph like:
> 
> The 802.1D-2004, removed the original Spanning Tree Protocol, instead
> incorporating the Rapid Spanning Tree Protocol (RSTP). By 2014, all the
> functionality defined by IEEE 802.1D has been incorporated into either
> IEEE 802.1Q-2014 (Bridges and Bridged Networks) or IEEE 802.1AC (MAC Service
> Definition). 802.1D is expected to be officially withdrawn in 2022.
> 
> Thanks
> Hangbin

Looks good, I have some old code to modify in kernel STP to do RSTP
but porting is a lot of work (mostly testing).

