Return-Path: <netdev+bounces-187632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4866AAA86FD
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBFA188C780
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F21EA73;
	Sun,  4 May 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9XR9Tly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2848BE46
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370429; cv=none; b=LsJtQxq/3m6G4yjP9cAvQ11s4AdqxQh6XHKmwknbNIchBrniYlXrTyC9OnnRBbWtHiOZebdwip+68C5MdlNRnr7e6mg7QipMUcslxgXAqS0YYMLDsu184MqO+o24uS8tqPbyeBP5uW43u3o6EJdY9f4TTe1uGshwCmM/cu+27dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370429; c=relaxed/simple;
	bh=QRaVQngXVw8+L0qnpVrbm44CBMubbLXZxjFsbpk1F80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZs98WtBT/C5F6dzrvPm0Gc158+1GH9y5WYayeyasZZDh2+zo8nid7BY0cth7tD18RQNSsLQnkgi0q9siUa0ODSNruDR5JkOm+NvVRdnXxGxvplTm5dcGaw2FxJ6HcekUvR6dcKHltyBzhyPI+0Asb13XT87Miuo6haKEk+Ra5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9XR9Tly; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so31523475e9.1
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 07:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746370426; x=1746975226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRaVQngXVw8+L0qnpVrbm44CBMubbLXZxjFsbpk1F80=;
        b=Q9XR9TlyGMvPmcLy2uD8+UFo+I4iIvlbWScMhlCMkRrlLG3x3nJjJhJ8NZKxCViJQV
         zIzgUb/V8mDavy1j8Ukc48nrtuWqkJEjYlDZDcsZ2sNI2lXrhHPQU0ascCDg0538XttU
         s9z+tJuj1zjD5jcsJJ8ResO48Kv5Lm45nL732Y92lCIxGTc0byoGBEEQgh/dHsVVmawb
         9eMAtR0gXpb6vAleQCsujF0NdwTVci2+225VWdYMLaZCatXlHCbRA9JokvhoPhsnH80P
         xlZyN6NBl1MG3i1AKeQtd/tMGUuePSALFQY/UzhRnbqM1j+RaB9bGYgawQSIiZw91h2h
         ElnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746370426; x=1746975226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRaVQngXVw8+L0qnpVrbm44CBMubbLXZxjFsbpk1F80=;
        b=OI9N48WfGHS9kMHTbh0tIa9krramCAYCgMwk6Co4qNRl8WO51T61HRk9Xgy6MX3Xoz
         W/DzGL9NJNC7txRzh1T0aaSJmtg1U4emY1tXqCis5mmswuWoFKFraQ/IKHqzn37KpHkf
         KGuwaPgUghCvPVGWy7uSwhn8ATCnsKsa/4lEDsv8GXjOEE5F2Uc5RSjEx3DdvmTOK8r9
         Ff+fzQpRwaKJjMA0wi1oxy4Nbxk6SN3Zj2g91XmUWv0cS6sJOxbNZ59ixYafZ+Z4MVLK
         8lbdQVxnIhZzpxyTwNH2t+9fGmWvzy/dwlN7bpiV89gFFXYdt8V9uzpyX6u0+Sw5CPTk
         JujQ==
X-Gm-Message-State: AOJu0Yzi8L+O7BNMGrRbM+WHEQ8FW3Wyo5uFqYyELJaGPT3s/wjxZDzt
	+ro4TxlZ/eO/i5rmNE9VIEgYEHN8Nmg4lrDP13BCMEBacgakOiyvs7KSHo1apVw1QKJZUbSBZNd
	kZ8EO4fEVvmVnGWgrG+1OuEqKQTe2aA==
X-Gm-Gg: ASbGncs8Yl8CRhUBpxKdjNtRmd5U5aQorgMqEk0MwMnHklcITgFRytq+QqIeDGNxFlZ
	LDCeyR6xVW/ko6lSQjdCMHYAR1FXsw9blv2xj+1a7DFCPFPACsBue6GcsEd1PHkI7du+0RwbjVK
	UiVXHYgw7t0qiv/TwbHqRzYdNYS6zBwyVWU33EmNVR9lumK6F6ZBiDaAg=
X-Google-Smtp-Source: AGHT+IGa6e4WUVrNvBGArzMhSOP3R4KHPvKEhd2GYhVE2+gghozOiyaAnOCCTeSxhtz7EQ7x10M/lY5DR4IVsvyEio8=
X-Received: by 2002:a05:6000:2289:b0:39e:cbca:74cf with SMTP id
 ffacd0b85a97d-3a09815877bmr7537913f8f.6.1746370425532; Sun, 04 May 2025
 07:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614223013.126317.7840111449576616512.stgit@ahduyck-xeon-server.home.arpa> <20250502165441.GM3339421@horms.kernel.org>
In-Reply-To: <20250502165441.GM3339421@horms.kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 4 May 2025 07:53:09 -0700
X-Gm-Features: ATxdqUGUr-UFWfgN4ZNyrIOEM3BM1H7xeUJDp5qu9o1SY7NuFq4ME3CLXZhvdmI
Message-ID: <CAKgT0UeQ6_HSQ=2E6-DNuKA0yMWbYYhhZrKPvhBEhmwODmbSeQ@mail.gmail.com>
Subject: Re: [net PATCH 6/6] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:54=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, May 01, 2025 at 04:30:30PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > This change pulls the call to fbnic_fw_xmit_cap_msg out of
> > fbnic_mbx_init_desc_ring and instead places it in the polling function =
for
> > getting the Tx ready. Doing that we can avoid the potential issue with =
an
> > interrupt coming in later from the firmware that causes it to get fired=
 in
> > interrupt context.
> >
> > In addition we can add additional verification to the poll_tx_ready
> > function to make sure that the mailbox is actually ready by verifying t=
hat
> > it has populated the capabilities from the firmware. This is important =
as
> > the link config relies on this and we were currently delaying this unti=
l
> > the open call was made which would force the capbabilities message to b=
e
> > processed then. This resolves potential issues with the link state bein=
g
> > inconsistent between the netdev being registered and the open call bein=
g
> > made.
> >
> > Lastly we can make the overall mailbox poll-to-ready more
> > reliable/responsive by reducing the overall sleep time and using a jiff=
ies
> > based timeout method instead of relying on X number of sleeps/"attempts=
".
>
> This patch really feels like it ought to be three patches.
> Perhaps that comment applies to other patches in this series,
> but this one seems to somehow stand out in that regard.

Yeah, part of the issue is that these patches all became an exercise
in "flipping rocks". Every time I touched one thing it exposed a bunch
more bugs. I'll try to split this one up a bit more. I should be able
to defer the need for the management version until net-next which will
cut down on the noise.

