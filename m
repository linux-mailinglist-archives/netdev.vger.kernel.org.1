Return-Path: <netdev+bounces-42648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED467CFB73
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E47282033
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA0B2746E;
	Thu, 19 Oct 2023 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="CXRdo6q2";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="JM9fLk3T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B2CDDA6;
	Thu, 19 Oct 2023 13:42:25 +0000 (UTC)
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Oct 2023 06:42:23 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60188124;
	Thu, 19 Oct 2023 06:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697722756; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EFD3QYbBNAwdIpiJCeXqcDPAWe8hCm0JWYvEzP88ly6Xj65qtskAfhsbd6dcrjPGQy
    MD7awJq1dw6or2Uv+SaN+L+sra8ss5jqNJxp63+tz/lcNHE1n+JLk2g4MLVWg2gLUOrQ
    JxC2L8btf3fJbiSB3AYrkuJjpdGdiACScE08DSroIUGfYXFkyBX/EjP84XUgxipMz7GQ
    aCOGDbmAzKo6WZYvGgvKORuGNm45yGPOxPpu3EKb1uJf2+WjlGmGlZDSdt5KAYniaVK1
    INhePkKyWz7YNTegGUkByLL3LTZoyknd8a5M2wgqqipzLnzlt/xWemvaviU++ZSytiAw
    c65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697722756;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IiAUACoAmD1dZiYlatQomGi3MwVID43ZHiBQH5Q1d+0=;
    b=ljIvctqtJvBDkdGnIRJ89iB7acCc9h66+A11crb8qzilgureOvyhJmqOEaozHstcy4
    sJvR3TpqSPwzJf/14S0vCHfJP9HiYLZjuipQF//++FlYHuOY2wVIYpj/Ansb6Uv3e5be
    QevS51b6PuYjtrSqj2oDJ67Ans3cl1I0yz+RoruXCc/+CSCl5BCQGoUlj7JRn0ZA5RAd
    LXNd2PdqNqLJPbxAkcsh/gNS0IBpbMU6hzZiLjbNYPBQG0aaezuA36KLtk8kcDLOkc0r
    xpn8nYQJMGTYDRaXstoWXszfIbfGJdxuc63ht2MSS07IckNWnpfZVVQuPR5y4Q4EqZz1
    Lepg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697722756;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IiAUACoAmD1dZiYlatQomGi3MwVID43ZHiBQH5Q1d+0=;
    b=CXRdo6q2oEJBSO1pHcZjrJTrxUYyk04S2kUpFRHmpcxV8LaWVhb+Jtt3ec8qszNyGd
    ZkOjqu3sOS0A+XVDJZL7tWoW1fQFepK4BR7TkOLIOyQH9CWbZpNGL2MRNkQNWXC1S4gc
    8ZmZBFGFEhSGp4efXVDyHLs9+FIrRqyhTchT/Yd7L40fSy4cDjFWTDFnRFg6hseKto+/
    DA+EYkHsEg1NdS+v98hBFIm1GyivoRUCMokKnqiM3ncmn1VrBdQGmUbW4lnwCAK7pX1n
    Bfqd2HA5eIigfii4pDdz/W7u1sdijTNdf8SlCA1OqOpHz7cPk99jPu5PJy3pyho7bYiZ
    S47w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697722756;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=IiAUACoAmD1dZiYlatQomGi3MwVID43ZHiBQH5Q1d+0=;
    b=JM9fLk3TtDDldKevllM9q3uJh8Tp3iozbo0xtn50KB3M9rODzOytQBlRSWBClThq4r
    YdYZC6BDhDtiYyB5zLBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.9.0 DYNA|AUTH)
    with ESMTPSA id j34a49z9JDdFDo9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Oct 2023 15:39:15 +0200 (CEST)
Date: Thu, 19 Oct 2023 15:39:10 +0200
From: Stephan Gerhold <stephan@gerhold.net>
To: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: wwan: replace deprecated strncpy with strscpy_pad
Message-ID: <ZTExfv2aHPD2B1ze@gerhold.net>
References: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>
 <202310182232.A569D262@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310182232.A569D262@keescook>
Content-Transfer-Encoding: 7bit

On Wed, Oct 18, 2023 at 10:35:26PM -0700, Kees Cook wrote:
> On Wed, Oct 18, 2023 at 10:14:55PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> > 
> > We expect chinfo.name to be NUL-terminated based on its use with format
> > strings and sprintf:
> > rpmsg/rpmsg_char.c
> > 165:            dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
> > 368:    return sprintf(buf, "%s\n", eptdev->chinfo.name);
> > 
> > ... and with strcmp():
> > |  static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
> > |  						    rpmsg_rx_cb_t cb,
> > |  						    void *priv,
> > |  						    struct rpmsg_channel_info
> > |  									chinfo)
> > |  ...
> > |  const char *name = chinfo.name;
> > |  ...
> > |  		if (!strcmp(channel->name, name))
> > 
> > Moreover, as chinfo is not kzalloc'd, let's opt to NUL-pad the
> > destination buffer
> > 
> > Similar change to:
> > Commit 766279a8f85d ("rpmsg: qcom: glink: replace strncpy() with strscpy_pad()")
> > and
> > Commit 08de420a8014 ("rpmsg: glink: Replace strncpy() with strscpy_pad()")
> > 
> > Considering the above, a suitable replacement is `strscpy_pad` due to
> > the fact that it guarantees both NUL-termination and NUL-padding on the
> > destination buffer.
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > 
> > Found with: $ rg "strncpy\("
> > ---
> >  drivers/net/wwan/rpmsg_wwan_ctrl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> > index 86b60aadfa11..39f5e780c478 100644
> > --- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
> > +++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
> > @@ -37,7 +37,7 @@ static int rpmsg_wwan_ctrl_start(struct wwan_port *port)
> >  		.dst = RPMSG_ADDR_ANY,
> >  	};
> 
> "chinfo" is initialized immediately above here, which means that it is
> actually already zero filled for all the members that aren't explicitly
> initialized, so the _pad variant isn't needed. I suspect Dead Store
> Elimination will optimize it all away anyway, so this is probably fine.
> 

Hm, strscpy_pad() is neither a typical compiler builtin nor an inline
function, so my naive assumption would be that this could only be
optimized away with LTO?

But I don't think this is particularly performance critical code, so
maybe it's even better to be explicit in case someone ever changes the
way chinfo is allocated.

@Justin: Nevertheless I would appreciate if you could briefly reword the
commit message and add a note about this. Someone reading it later might
get confused or mislead by the "Moreover, as chinfo is not kzalloc'd,"
part. As Kees wrote, even without kzalloc the struct initializer of
chinfo does actually ensure proper zero initialization of the missing
members.

Thanks!
Stephan

