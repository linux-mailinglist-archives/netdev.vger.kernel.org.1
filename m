Return-Path: <netdev+bounces-187631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41DBAA86BF
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 16:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F591895C2C
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97381624C3;
	Sun,  4 May 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWDbVoAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896517996
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746369475; cv=none; b=eDbbu6i05+8vDmJQlRwitOVkgwGwyjaxKk1+Gw0bz+3bkax9Yw10tlYtakqk8338dE7mn4TVxOygTJIN+74GYXJYAh4GnN2xUNVBeiHBOsma/gNQQxXFaBplyehTUfZqUVXElfKNYGbqiC1BzNrTvU1F0zxb6obwIqdNM1IkN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746369475; c=relaxed/simple;
	bh=1BrU4fXWe3P0ynTA8Tysp+mn3XmN6hEZtIqTO7Wh/yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s11nL89j0TJVUbu7QDTxxqSxJwln7YVeqP87P9swXEhnPC2JptWDoosVsbN6McndogAidInFBAdGriHxqFRRyo/1CT9MM+ibMEeFAS+6lXsk3eb3J2EZK/O4Od/rvkk+eo5gz8TKEYPe0ZRJ2xbhyA9aa7b9cSBSRjhqG2WO1i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWDbVoAG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so4265974f8f.1
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746369472; x=1746974272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwQRu/CWwEnkfaJOMGeH+AMQla5Wl5OgozdTEvcGGBw=;
        b=UWDbVoAGDKHfTiq3IiAiJI+EqhbqH+OeN198KcvCKi/7XcCs/wsIvFOZQCcIR9FNbl
         h7V9B1eM+Li89YQNPPkn9JffywE0D4WulvW2kEhgUjrz43j84jcSiMykkmXtmt+5UaCf
         GkJ99qGTUN7ZcEKbJYw4+gsMrtaUVWQAQGI4m9rx2YBkDUbs7QDV0FDLHa/00yaHXxu0
         pI/TJXjRVkvgmEMtJyROViu7dZb1bQ1Pfiw0+O6JzQUBmnBNXDtlu++OJ+L7XoMw8JyM
         vvCAsbsZkJU+VvWGsy1dAD0XH6L5qvCF4VSd7LHQQMpB4u+ZM8LtG4u5X3Jy+zK2Ig5q
         uczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746369472; x=1746974272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwQRu/CWwEnkfaJOMGeH+AMQla5Wl5OgozdTEvcGGBw=;
        b=DuLFohJBEXIa0cJ541YzuD5MJFT758ZP8B4cYpGl4JIhfxmsoPAchyMUnkS6/XsV40
         C8T+DcuZrJtrGw3VyBHaMkg5tWGyhGEdopbKI2jtELlo4NK7bxqV8gGZI1oPSBnTIcRE
         XmUJyC0u2SSSYVGkPE75Uk55yYatfgWH2EBejOfDVQq8oNKU9gZcjd2J19LP6XaFJBO0
         B8VCWGyIxyErTXJ3SjkWNb7Kph1Cei2suhUS2DyaAFPiQSiDIAw+4aUhgoFR2AzlUOrE
         pDwHUgP2sUea7W3P8SYWPYFb3RHcLUq4vD/qWKtHRAB5GAHyOY+YPfyDUYget9wzOt0E
         lF1A==
X-Gm-Message-State: AOJu0YybBRKNNL4LT8XthTrJB6Uqab0cIPrHt9VccB7+L4aNntq2CPPW
	L+6NoqfMUtU58pLtQQviME+dwkXG4KNMyiGQJALze4p+zYq5XoZptYXVuzoCVVSPKawR94V8ugB
	uVjYXvD+jA2b1HWrPi26+HK7+vW0=
X-Gm-Gg: ASbGncub8049e+5wxnkK3YHV9EUQU28tbbA5rRzrNybixKKPoWIPoFS6Xp8/z3dueB+
	BZ+3N7GrzcdHnf96rgteLXUZM3e0NemU3PCsxhhxMYRxE/1capbIXgGQpG7ebteBT8xdG2v8J+V
	UtdytTAcpoXZQZETdKqOSsdph/un4eBlJ+nNtknc6fp4BEm0tfs1eJt4M=
X-Google-Smtp-Source: AGHT+IGtH+HOULJ0PkwKMYsgwvUEWp8VypVvoyRBUJbps1Ue7FGCDY5jl/mDCrOrBDh6pzROxQBcYLd6PiX2PaUIr00=
X-Received: by 2002:a05:6000:184e:b0:3a0:90c6:46df with SMTP id
 ffacd0b85a97d-3a09fdf6b40mr3248239f8f.48.1746369472095; Sun, 04 May 2025
 07:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614222289.126317.15583861344398410489.stgit@ahduyck-xeon-server.home.arpa>
 <20250502104523.GH3339421@horms.kernel.org>
In-Reply-To: <20250502104523.GH3339421@horms.kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 4 May 2025 07:37:15 -0700
X-Gm-Features: ATxdqUHUAlDo_qan_PWdOEXWnxMu1q9A75vqe1frUb7f4BYnVx6yUGTdN3KvL6w
Message-ID: <CAKgT0UcnUEY9JMajO-18vJ7wNCXt6LV0WM61imwPi=y=d_TEqg@mail.gmail.com>
Subject: Re: [net PATCH 5/6] fbnic: Cleanup handling of completions
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 3:45=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, May 01, 2025 at 04:30:22PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > There was an issue in that if we were to shutdown we could be left with
> > a completion in flight as the mailbox went away. To address that I have
> > added an fbnic_mbx_evict_all_cmpl function that is meant to essentially
> > create a "broken pipe" type response so that all callers will receive a=
n
> > error indicating that the connection has been broken as a result of us
> > shutting down the mailbox.
> >
> > In addition the naming was inconsistent between the creation and cleari=
ng
> > of completions. Since the cmpl seems to be the common suffix to use for=
 the
> > handling of cmpl_data I went through and renamed fbnic_fw_clear_compl t=
o
> > fbnic_fw_clear_cmpl.
>
> I do see this is somehow related to the fix described in the first
> paragraph. But I don't think renaming functions like this is appropriate
> for net.

I can drop this. As it stands we have a follow-up patch for net-next
which I had split these fixes from so we can most likely leave it for
there.

> > Fixes: 378e5cc1c6c6 ("eth: fbnic: hwmon: Add completion infrastructure =
for firmware requests")
> >
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > ---
> >  drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   22 +++++++++++++++++++=
++-
> >  drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    2 +-
> >  drivers/net/ethernet/meta/fbnic/fbnic_mac.c |    2 +-
> >  3 files changed, 23 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_fw.c
> > index d019191d6ae9..efc0176f1a9a 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> > @@ -928,6 +928,23 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
> >       return attempts ? 0 : -ETIMEDOUT;
> >  }
> >
> > +static void __fbnic_fw_evict_cmpl(struct fbnic_fw_completion *cmpl_dat=
a)
> > +{
> > +     cmpl_data->result =3D -EPIPE;
> > +     complete(&cmpl_data->done);
> > +}
> > +
> > +static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
> > +{
> > +     struct fbnic_fw_completion *cmpl_data;
> > +
> > +     cmpl_data =3D fbd->cmpl_data;
> > +     if (cmpl_data)
> > +             __fbnic_fw_evict_cmpl(cmpl_data);
> > +
> > +     memset(&fbd->cmpl_data, 0, sizeof(fbd->cmpl_data));
>
> Maybe I've been staring at my screen for too long, but could this
> be expressed more succinctly as:
>
>         fbd->cmpl_data =3D NULL;
>
> And if so, it seems that step can be skipped if cmpl_data is already
> NULL, which is already checked.
>
> Leading to the following, which is somehow easier on my brain.
>
> static void fbnic_mbx_evict_all_cmpl(struct fbnic_dev *fbd)
> {
>         if (fbd->cmpl_data) {
>                 __fbnic_fw_evict_cmpl(fbd->cmpl_data);
>                 fbd->cmpl_data =3D NULL;
>         }
> }

I'll make the change. There is a follow-on patch for net-next that
will add support for multiple completions. As such the code may roll
back a bit to the original form, but it will make more sense if
contained within a for loop.

