Return-Path: <netdev+bounces-153379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C69F7CD7
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A391651E6
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007C224AFB;
	Thu, 19 Dec 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxQc1liR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5A2111;
	Thu, 19 Dec 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617454; cv=none; b=jGyFVPKwfmaAr21Mg6LOVEL8faLtVtKpAtuTo/hdtVVznYzjsbXO1H0b/19d9RverWgzioSfLE2Z0kAkxIJokCUKrhle7O4xfkBHbL62oUODLwosr4Uutnw7FFzgjQxHRcOPzra3Bf4hnLeGfmGqDoIcyMBeRxAwLq19SK4Cv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617454; c=relaxed/simple;
	bh=E3wf8TOoKmPE7cP1MXBQMHxHy5JaPrHfgU747vTnZ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9taWiY/Oohl6V0w7MCXDjSheJKePSo8xwcRChGLJWYTYfouf9eB5BfnlI2Fo8Rfq716NVR/wk/8y+EUwPTJsIxm44kmmq/cGohzTEVwEgVWbySeXpW0taY1/mo9crQ3lzaKbg83X2GItjs+CD5WxTANfQ44tj4byY1YVn5xSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxQc1liR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso1443099a12.2;
        Thu, 19 Dec 2024 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617451; x=1735222251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofqsslm0RVD3ogGqNQ4RIQnAfKvNRRygfEx58KTogKk=;
        b=TxQc1liRc5aO7oI/bkmFFirq8201Z1AUkNbRT3AEuPTzsRnG+jPnNyGp7r/1nfpDgt
         p9RxkQ1lP8m5zcfMzbm2LGUye4kEweZHea7CzGTjRKyF6fR2QpOkXuyHeYGZN1XF/WUw
         PYimSqEQkU+iTWmiNf4nlGuwAm5llrkdZ9ROtszVleqFnbQN5S94yGqKKEy0Pu6DgSqw
         sOSx07eBpwc10fbdsxGcIYRZxWSnvGhDB6zZQkQdy5Jd+p+o4RIiMHg1BA5FWa1c3t5J
         4umTzl0aDJlt2gwd+MJGK3Rk86gA+Lt8V4iWZhGVtvTUZbhPek2tg0RCgM6ygU/kl65u
         NGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617451; x=1735222251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofqsslm0RVD3ogGqNQ4RIQnAfKvNRRygfEx58KTogKk=;
        b=ZQjBlVxWmXCfuAXyzl/jT4aH0mkKeOOgB+4FPsYS4JuhciH8DtDM8g5uEIq3cK7BnU
         Yf12TAi5kwP2J/Cr7YzB3ePZldts+09FR5ZldX73OA4oNFOEhKdKUjEvG7qX2Z0+/Tpf
         S+Pxwfxe4y9WowBSxgHHF/hAszTnbC2sBeX/0MgMPhesQCQpmHvby5koHHyHcgLZatvE
         QstAo3TKFfKKV3nMzUm9VT0fZaF6mobcDw8mM8Lv7bBEjIbRbpQkzRxY3Mf1xXL0nOdC
         fALie73YUelwJ+UbtKlnG4ss4VRvjKMcSalXA19DVAaTeM7WYcWQZPj9mVaC0ORYubBW
         5Z5A==
X-Forwarded-Encrypted: i=1; AJvYcCUtwpZvr0vReVJXFvyoNjH/198Hhfj1jc+xyTzY2cJsLjSVWJmN64DTIukac5p9RFjpKqfDBOC+@vger.kernel.org, AJvYcCXWJrl1hx7kEQHcJzEK6IrAhv8rOOk0n4TZ0kiax9ePvwiiIo+yd35d1TCicl6/W72Vrz5OmpfnkCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQw5SqQwbyKziu2Jn9jcyYbXc//ZsD2c09sebovsiZ/CRv1QTv
	s4mKclkLOOVsi0zkFVnwcwg6FcHQCDUVziLRtpkVcKwpKU2uzrCBewCcx4lXFD+/veM00xS/tcl
	uIzvPl2O6atPKw+aogNyzlfnVMbk=
X-Gm-Gg: ASbGnctKNw1BkvQBvGzxJqMPGbf1CSWR5uO+gneHuDJmMXbmhcAQE5SViI1p3jMjSgw
	LHoAlwdlZ0fZnGUc8HtFRK0p6Ihk3NpHm/AVQhdI=
X-Google-Smtp-Source: AGHT+IEzk6t2j53LVAASS7A1AuxYbOu4dy4dFxol4mCuy36/IYJaRA6nn75YoYOEPweKxadxqbfYrzeZR/q3CjrYtWs=
X-Received: by 2002:a05:6402:43cd:b0:5d0:cfad:f6c with SMTP id
 4fb4d7f45d1cf-5d7ee418b93mr5684598a12.21.1734617451133; Thu, 19 Dec 2024
 06:10:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218144530.2963326-1-ap420073@gmail.com> <20241218144530.2963326-5-ap420073@gmail.com>
 <20241218183547.45273b87@kernel.org>
In-Reply-To: <20241218183547.45273b87@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 19 Dec 2024 23:10:39 +0900
Message-ID: <CAMArcTUCy2Wkrw5foPheHq=1x5SeDcwp0uvSniGzOGZudVqY+w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/9] net: ethtool: add support for configuring hds-thresh
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 18 Dec 2024 14:45:25 +0000 Taehee Yoo wrote:
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index 4e451084d58a..4f407ce9eed1 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -78,6 +78,8 @@ enum {
> >   * @cqe_size: Size of TX/RX completion queue event
> >   * @tx_push_buf_len: Size of TX push buffer
> >   * @tx_push_buf_max_len: Maximum allowed size of TX push buffer
> > + * @hds_thresh: Threshold value of header-data-split-thresh
> > + * @hds_thresh_max: Maximum allowed threshold of header-data-split-thr=
esh
>
> nit: s/allowed/supported/

Thanks, I will change it.

>
> > +u8 dev_xdp_sb_prog_count(struct net_device *dev)
> > +{
> > +     u8 count =3D 0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < __MAX_XDP_MODE; i++)
> > +             if (dev->xdp_state[i].prog &&
> > +                 !dev->xdp_state[i].prog->aux->xdp_has_frags)
> > +                     count++;
> > +     return count;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_xdp_sb_prog_count);
>
> No need to export this, AFAICT, none of the callers can be built
> as a module.

Okay, I will not export this function.

>
> > +     hds_config_mod =3D old_hds_config !=3D kernel_ringparam.tcp_data_=
split;
>
> Does it really matter if we modified the HDS setting for the XDP check?
> Whether it was already set or the current config is asking for it to be
> set having XDP SB and HDS is invalid, we can return an error.

Right, it doesn't need to check modification.
I will remove it.

>
> > +     if (kernel_ringparam.tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED &&
> > +         hds_config_mod && dev_xdp_sb_prog_count(dev)) {
> > +             NL_SET_ERR_MSG(info->extack,
>
>                 NL_SET_ERR_MSG_ATTR(info->extack,

Thanks for it too, I will use it.

>                                     tb[ETHTOOL_A_RINGS_TCP_DATA_SPLIT],
>                                     ...
>
> > +                            "tcp-data-split can not be enabled with si=
ngle buffer XDP");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max=
) {
> > +             NL_SET_BAD_ATTR(info->extack,
> > +                             tb[ETHTOOL_A_RINGS_HDS_THRESH_MAX]);
> > +             return -ERANGE;
> > +     }
>
> Can this condition not be handled by the big if "ladder" below?
> I mean like this:

Thanks for that, I will try to apply it!

>
> @@ -282,6 +276,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, stru=
ct genl_info *info)
>                 err_attr =3D tb[ETHTOOL_A_RINGS_RX_JUMBO];
>         else if (ringparam.tx_pending > ringparam.tx_max_pending)
>                 err_attr =3D tb[ETHTOOL_A_RINGS_TX];
> +       else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thres=
h_max)
> +               err_attr =3D tb[ETHTOOL_A_RINGS_HDS_THRESH_MAX];
>         else
>                 err_attr =3D NULL;
>         if (err_attr) {
>
> >       /* ensure new ring parameters are within limits */
> >       if (ringparam.rx_pending > ringparam.rx_max_pending)
> >               err_attr =3D tb[ETHTOOL_A_RINGS_RX];

Thanks a lot!
Taehee Yoo

