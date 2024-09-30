Return-Path: <netdev+bounces-130532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7071798ABB5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321CD281B92
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E451990CF;
	Mon, 30 Sep 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVglGRa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C22B9A5;
	Mon, 30 Sep 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719936; cv=none; b=B2+gzIcrSqeXWQN6UBPirnwVcVqCQSVt8RuUk2GqPIjUJ/nAp5nKA1zOjgmhpdMcV8bXjXYP03aBVax+XKiftAP6JUQdV9bPRnjFuDZG9SvzSuTaaLQLb4T7f1Fscc4DJz/2U7dVwSizOb3BPO4PmYQ9LPHgq0SyYevL8rFPR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719936; c=relaxed/simple;
	bh=/lN8ZaNf0afjkLuFEFyKuOfAN1CXxRdISNa+Bf37E4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCStOo5Rd+Gg5bK8O8WhXfvyjqxzE9W83ex0c0uenQB+vgmBEN5PD4je3hxtT/0swQ8aSn6H4Hgmj5O4t7fUCJg1iTLlrW1vFOcCG3KEULiWG6YnYszYlTN1WQmsylD6HhGzcITJlXjewJsInhOmHi2QUMT7iMpc3izxPP7G4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVglGRa/; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84e8406d082so1316468241.1;
        Mon, 30 Sep 2024 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719933; x=1728324733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nae0lLGc3msz1EPm/wCvclJqISqo0iwRYOPMJybkAR4=;
        b=QVglGRa/kXK2N8TfaVEqvi911yk//UFLGbaVnPlkA0CRCKWRht4VgoN6poPlDRi/A+
         f549Z2/Zplnxu2Kd1U907RzMCGw45g1XfXGDP16N9zTLC2lM96IVjZwwwmNF9IGPPdKc
         ynEhmc/grWEQN4Xv7YlfgQ/fn4TLducpNmL1s3exVjBIMtt4QGs7P1J3g0jqdnlYud8p
         gR+4iSBs92PyziZb/RNZb2lgqnAFbIuPDOe2GzBAMD0bikaK5MIj40qxHJPsuaqHH1p+
         kYfoNQQ9Rk0ME4zK3TP8ui25YgA1HwHoAKck9yCXdYnAcqweb9Le3j0j5rYlKq8hzWLJ
         gjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719933; x=1728324733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nae0lLGc3msz1EPm/wCvclJqISqo0iwRYOPMJybkAR4=;
        b=h8Ye5X255fQ4tS+BAVXkDzDi+5awoAxNB24X8BFqbA0fkpU3KbQmiUxPKknLKeyira
         erUCAbF6IKnxNK5kqbTY98TnxoZ2x0YDCiFiTPq2qhxq3qxyqYfgF4Ji5pHQWeRpVWx8
         aDQWZbiAJlbliLxDVv6D0bFRwljYMFm/y1nYP7yP9URJHr6qk9qFvtt2bLmxqyGNo4xe
         8JnSSYzQBmefj9U/70zOHmspjenGQfxF3lwXCGrfTaxQ0HmOKIiZFrft/g8SounEDGdb
         SJnMOz4uVwX7+kZeocCF4qk8C9CMxLUi7rJ95TJUfWZ821qao8Kp+027Ttg1iy7WBjUW
         tNWg==
X-Forwarded-Encrypted: i=1; AJvYcCUPfr4fiu9DdOWDx943kbq+cOqT8IpuXTLa0udAonAKO8wck4io3YdAwl7nKqXFlM+sjCmG9FPN@vger.kernel.org, AJvYcCV+7JwvFJpfrwsIMrL/kdxF6OeEQbiDTbetfQxLW4zxWQ6e8nvao5ZxaesGtGNnOBb6pcHJ42/52HHq/r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53YBS5c0MOJXPowONJv2KYMYf+dkhvkJ+BK6ZlwBedZM0E9bA
	s4mM63ZYlJQxY4p2QEgmElWPWdZs15fk+kb39lIkRC9iRNSvC1IQP/UmUjABqAPwYmYR05O5Wop
	5bkxigYIq0vAgF+lvEWDM5mLDjIY=
X-Google-Smtp-Source: AGHT+IFI78teiytJ8yqzNRCyI/37B7MGRbtwylUc+wkZYU6lSagTj374LoWWHHQpNUGMBGoog4oXa40unD4PuVcxUCY=
X-Received: by 2002:a05:6122:2a0b:b0:50a:c31b:33d6 with SMTP id
 71dfb90a1353d-50ac31b36famr2878749e0c.9.1727719933464; Mon, 30 Sep 2024
 11:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923113135.4366-1-kdipendra88@gmail.com> <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
 <20240924155812.GR4029621@kernel.org> <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
 <20240924181458.GT4029621@kernel.org> <CAEKBCKPz=gsLbUWNDinVVHD8t760jW+wt1GtFgJW_5cHCj0XbQ@mail.gmail.com>
 <CAEKBCKOykRKyBGzBA6vC0Z7eM8q5yiND64fa4Xxk5s5vCufXtA@mail.gmail.com>
In-Reply-To: <CAEKBCKOykRKyBGzBA6vC0Z7eM8q5yiND64fa4Xxk5s5vCufXtA@mail.gmail.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 30 Sep 2024 23:57:02 +0545
Message-ID: <CAEKBCKOLPUYJaXOG9p8Gznve86vq+GxOde+iZAYRCPqdjEAgsw@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi ,

On Thu, 26 Sept 2024 at 11:27, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> Hi Simon,
>
> On Wed, 25 Sept 2024 at 12:07, Dipendra Khadka <kdipendra88@gmail.com> wrote:
> >
> > On Wed, 25 Sept 2024 at 00:00, Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Tue, Sep 24, 2024 at 11:42:58PM +0545, Dipendra Khadka wrote:
> > > > Hi Simon,
> > > >
> > > > On Tue, 24 Sept 2024 at 21:43, Simon Horman <horms@kernel.org> wrote:
> > > > >
> > > > > On Tue, Sep 24, 2024 at 08:39:47PM +0545, Dipendra Khadka wrote:
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > > > > > > > Add error pointer check after calling otx2_mbox_get_rsp().
> > > > > > > >
> > > > > > >
> > > > > > > Hi Dipendra,
> > > > > > >
> > > > > > > Please add a fixes tag here (no blank line between it and your
> > > > > > > Signed-off-by line).
> > > > > > > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > > > > > >
> > > > > > > As you have posted more than one patch for this driver, with very similar,
> > > > > > > not overly complex or verbose changes, it might make sense to combine them
> > > > > > > into a single patch. Or, if not, to bundle them up into a patch-set with a
> > > > > > > cover letter.
> > > > > > >
> > > > > > > Regarding the patch subject, looking at git history, I think
> > > > > > > an appropriate prefix would be 'octeontx2-pf:'. I would go for
> > > > > > > something like this:
> > > > > > >
> > > > > > >   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
> > > > > > >
> > > > > >
> > > > > > If I bundle all the patches for the
> > > > > > drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
> > > > > > work? Or do I need to change anything? I don't know how to send the
> > > > > > patch-set with the cover letter.
> > > > >
> > > > > Given that one of the patches is already at v2, probably v3 is best.
> > > > >
> > > > > If you use b4, it should send a cover letter if the series has more than 1
> > > > > patch.  You can use various options to b4 prep to set the prefix
> > > > > (net-next), version, and edit the cover (letter).  And you can use various
> > > > > options to b4 send, such as -d, to test your submission before sending it
> > > > > to the netdev ML.
> > > > >
> > > >
> > > > I did not get this -d and testing? testing in net-next and sending to net?
> > >
> > > I meant that b4 prep -d allows you to see the emails that would be sent
> > > without actually sending them. I find this quite useful myself.
> > >
> > > >
> > > > > Alternatively the following command will output 3 files: a cover letter and
> > > > > a file for each of two patches, with v3 and net-next in the subject of each
> > > > > file. You can edit these files and send them using git send-email.
> > > > >
> > > > > git format-patch --cover-letter -2 -v3 --subject-prefix="PATCH net-next"
> > > > >
>
> Do I need to maintain patch history below  Signed-off-by for each
> patch when I send them in the patch set? If so, what to do with those
> which have v1 but no v2 but the patch-set in v3?
>
> > > >
> > > > Should I send it to net-next or net?
> > >
> > > Sorry for the confusion. I wrote net-next in my example,
> > > but I think this patch-set would be for net.
> > >
> > > ...
> >
> > Thank you Simon for everything.
> >
> > Best regards,
> > Dipendra
>
> Best regards,
> Dipendra

Are we accepting any changes related to the error pointer handling for
the driver octeontx2?

Best Regards,
Dipendra Khadka

