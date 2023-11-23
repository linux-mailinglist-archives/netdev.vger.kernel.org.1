Return-Path: <netdev+bounces-50625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B37F65EE
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 19:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666E8281AC8
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49494B5A1;
	Thu, 23 Nov 2023 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqK3mKCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E3D72
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:04:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso932794b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700762643; x=1701367443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stx+9AzS1hxNweTdFlkIrchUwRIllZD+BwM1bokQ+ic=;
        b=BqK3mKCDWIwBzSxmXydXQJJhC2biyeWaSvLy+6yvYRhjhi1fl8/kV9do2h98szU/6u
         6FBbFczf3RtzU+/Q6a3LSoGt7a5Pn803KatNczvoY6F9mghJ2OYZSTLuh3CwJoh2t9h3
         y1XYC5Wd+kMhAc6JCSBWRhciupZl2qfJtVPKci/dHzH5wzOy4Sviw86YlA4fhLm3Ard/
         zBtFM56z7Mq/om1iCYYhoTb9BEMhigqCm2akjn5tvvTkWrHxSVuzd7qankCoiwkK1Bhg
         2x3qHxC3GWdJJO4kJcZO4gBnUIQ8XFSaA0ECEoC4+GxKnrwkWqQUJkV/8xXGzZpy4SzM
         XhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762643; x=1701367443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stx+9AzS1hxNweTdFlkIrchUwRIllZD+BwM1bokQ+ic=;
        b=oNuSfXuziQc6b0VEisVViTw+ZrHB+KNfPcflFZCqAP0Ag9PQAIV+ZfY9BeBn8PzhMQ
         tfFEFBRd5KY3JONkOQtf8koezpshZ13Zb4Gi3kAkEQq2u5LsiPmfMNanKnNQXZ1H+sUe
         ZPYYxWuwTTUCCTzAp+IG98UrZU20abPI0bW7+z1B32k21laS6y3uQ0gTFq74X41YN0uO
         HbHbJdxmxCDNOgj8hDjsPzVAmHhlmC7O604lyOwvtsQ4+peu79BWiGun+m1BX0EIMZpF
         dXNpC2GEw4TpJ4lDKr5yxkhXukVpYKuiKYxFY3fLHUXzJxUB35CpAmVjvzlaKqN0jugS
         Enhw==
X-Gm-Message-State: AOJu0YyYD+odzGFgaHqxdTN1YiIFqnoFxOFSSYehF0FhzNnBHNEckKja
	bNwi/csZXe0ITrC+hHLT4nY=
X-Google-Smtp-Source: AGHT+IHrWhEj86WzYWL6a84JcO1BoWmYmVa5WsWZqLO6yNPj2DSpacRa6t4UcmaO09lhMDici3w3bw==
X-Received: by 2002:a17:90b:3005:b0:27d:3be:8e13 with SMTP id hg5-20020a17090b300500b0027d03be8e13mr226491pjb.12.1700762642776;
        Thu, 23 Nov 2023 10:04:02 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id fs14-20020a17090af28e00b002839815d352sm1809723pjb.25.2023.11.23.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:04:02 -0800 (PST)
Date: Thu, 23 Nov 2023 23:33:57 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v3] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZV+UDY0B8AEkdVxc@swarup-virtual-machine>
References: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>
 <ZV8lf8L8Me+T7iIW@nanopsycho>
 <ZV9FnjRH6VTwWaaX@swarup-virtual-machine>
 <ZV9MpLBwS1ndszzf@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV9MpLBwS1ndszzf@nanopsycho>
X-Spam-Level: *

On Thu, Nov 23, 2023 at 01:59:16PM +0100, Jiri Pirko wrote:
> Thu, Nov 23, 2023 at 01:29:18PM CET, swarupkotikalapudi@gmail.com wrote:
> >On Thu, Nov 23, 2023 at 11:12:15AM +0100, Jiri Pirko wrote:
> >> Thu, Nov 23, 2023 at 11:01:19AM CET, swarupkotikalapudi@gmail.com wrote:
> >> >Add some missing(not all) attributes in devlink.yaml.
> >> >
> >> >Re-generate the related devlink-user.[ch] code.
> >> >
> >> >enum have been given name as devlink_stats(for trap stats)
> >> >and devlink_trap_metadata_type(for trap metadata type)
> >> >
> >> >Test result with trap-get command:
> >> >  $ sudo ./tools/net/ynl/cli.py \
> >> >   --spec Documentation/netlink/specs/devlink.yaml \
> >> >   --do trap-get --json '{"bus-name": "netdevsim", \
> >> >                          "dev-name": "netdevsim1", \
> >> >   "trap-name": "ttl_value_is_too_small"}' --process-unknown
> >> > {'attr-stats': {'rx-bytes': 47918326, 'rx-dropped': 21,
> >> >                'rx-packets': 337453},
> >> > 'bus-name': 'netdevsim',
> >> > 'dev-name': 'netdevsim1',
> >> > 'trap-action': 'trap',
> >> > 'trap-generic': True,
> >> > 'trap-group-name': 'l3_exceptions',
> >> > 'trap-metadata': {'metadata-type-in-port': True},
> >> > 'trap-name': 'ttl_value_is_too_small',
> >> > 'trap-type': 'exception'}
> >> 
> >> 1. You have to maintain 24 hours between submission of one
> >> patch/patchset:
> >> https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html
> >> 2. You didn't address my comment to last version
> >> 
> >Hi Jiri,
> >
> >I have read the above link, but missed the constraint
> >of 24 hour gap between patches.
> >I will be careful and not send the patch again within 24 hours.
> >
> >I could not understand your 2nd point.
> >Does it mean i should not include
> >test result e.g. "Test result with trap-get command: ...."
> 
> Does not make sense to me. If you put it like this, it implicates that
> the trap attributes are the ones you are introducing in this patch.
> However, you introduce much more.
> 
> 
> >Or
> >If it is something else, please elabroate more, which helps me to address your comment.
> >
> >I will try to clarify review comment, henceforth before sending new patchset for review.
> >
> >Thanks,
> >Swarup

Hi Jiri,

I will submit a patch which has only trap attribute only changed.

Thanks for the clarification.

Thanks,
Swarup

