Return-Path: <netdev+bounces-112106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99579934FF2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C4C1C20E4A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1913B7A3;
	Thu, 18 Jul 2024 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjQ4RNL+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9CA4D8B7
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316824; cv=none; b=F0GepKZNGZykFdSRln1Q6+X+KkCQiZF+M0eMt6q+VMCfCGEdc0J01e3jw6M3+UnHJvFUdX3hM0RoWCGk5UWju/D0hF5rDh43nFiX3dUx6rhwW+mhWg2VFvM5X273irCdVfBgTVGP86jboDVbVgkhpsuIAI0YA1oVGXCFG/iIyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316824; c=relaxed/simple;
	bh=19LO8/u+/HGuLxme/jBOI+Lmh9mVJxrDT7aVjpfMv3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBbEnESs1TwCNfHyUfQhXeWwlvpQX+JUGIXDTQk0mrYLYW9SAnIrtSfBA1oC/OyLJUuxfmTO7rQbKTLZqTDQ3/r5rjvHZXX4Fl9+4fWGR4OCsNh8fnOg0WQxlOs/P5xy6KkwKCYp0RSoZ+9mlcJsXF/lz31PQV64uXWRp+dDUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjQ4RNL+; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-396e2d21812so2584595ab.2
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721316822; x=1721921622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34ydbdQ+AXjDoopLQpbombMCzUo2nCYLDIGgHzMj7qs=;
        b=EjQ4RNL+dBLrwo/8MZqDM0DFLXMqM8prmYD9ahLK6GddI0uqcJDr+TXMw6QrEvcK3G
         9mPawCjcZPBiJX2gzv6/2uAsYubsLro4MhGmSqoUc0xYhcDEkeXkRFJgozDMwPm/XdIj
         bPMKnHGJyXFZ666kHTMNqWjj7TlTNqnnDOciKrqJr4lBTouoSt8SDDm8QCB9Cfyq6jm7
         eIaIBvC5t/oAVg4VrquJ6fcRANvxqLNv6PKQvrs6w0rDvEB5c6yxR3K7ocpp/4DrQcDx
         evebQz8oHBLqaIQmhfMDnfUrY+Xi+Jb3oVxe0fjxdG9831u/1vDhZn50PSAOBpsefU3g
         AzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721316822; x=1721921622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34ydbdQ+AXjDoopLQpbombMCzUo2nCYLDIGgHzMj7qs=;
        b=LDu+JVSEbbD/HOIFZ7xTJToSuFHlVD6NdM/h0vrX0mEO+TTytDE9JltdVXTIjexyeQ
         3CVwVaHgvBiJFQqFwsMxtlYNoDk7TDNRdqtY2LbSSRrFtoc4PHIfyyGvJ++BFkuRQIiy
         COcQHAy+Zz5iHFHrNKfPH5a4y+K9Vw5LqJjaX9jReKyOaGakGQxvUKp02NEKtHqNlSK0
         nbYw9mw7yImBD23goco3cp9y/igJzZTfPSoK4EOkArnD+n0ZFlPA0UdIcaHZsFEcMCef
         EvHv5eh8ZZXwBSxP4N4A60ot12Eu0Rn5/nKqO1JN4lEwQtmJAvJlIafRfmv+nANWgMrQ
         ih7w==
X-Gm-Message-State: AOJu0YxVvZgH1Qh/oq1bqtQWI4iRRwfGEeihMxDxTvslQseyxcm5zCab
	SnhArlhGTrJbIoI77y4qI3P8Gr+Sa7NAkM7wPKFo57UHlcAzmkdRjoBGRcWwxTqk8oWE+wcXk2g
	O++4G0yfUT5UOdqzQ2tw+fZRkcwQ=
X-Google-Smtp-Source: AGHT+IFISSpmKGr8UYGmzFsA1KbIRxi0BIdzKgOeKtAHJaqQ0MTSb3JsJgvZbga9qAokVEw+EKkPgE5Bc216+hhLDl4=
X-Received: by 2002:a05:6e02:12c8:b0:382:325c:f7ae with SMTP id
 e9e14a558f8ab-39555333179mr68044305ab.2.1721316822021; Thu, 18 Jul 2024
 08:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb6cfbcbdd576ce4f3b74be080b939a9398d21c7.1721268615.git.lucien.xin@gmail.com>
 <20240718062749.2bcea253@kernel.org>
In-Reply-To: <20240718062749.2bcea253@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 18 Jul 2024 11:33:30 -0400
Message-ID: <CADvbK_f5d+R7X7L=jMMtW+REjVM2v+A83QWpYBoKiQiobw33fQ@mail.gmail.com>
Subject: Re: [PATCH net-next] openvswitch: switch to per-action label counting
 in conntrack
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org, ovs-dev@openvswitch.org, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Ilya Maximets <i.maximets@ovn.org>, Aaron Conole <aconole@redhat.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 9:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 17 Jul 2024 22:10:15 -0400 Xin Long wrote:
> > @@ -2026,7 +2023,4 @@ void ovs_ct_exit(struct net *net)
> >  #if  IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT)
> >       ovs_ct_limit_exit(net, ovs_net);
> >  #endif
> > -
> > -     if (ovs_net->xt_label)
> > -             nf_connlabels_put(net);
> >  }
>
> In addition to net-next being closed please note there is a warning
> about ovs_net being unused if NETFILTER_CONNCOUNT=3Dn.
Copy, will move it into #if    IS_ENABLED(CONFIG_NETFILTER_CONNCOUNT).

Thanks!

