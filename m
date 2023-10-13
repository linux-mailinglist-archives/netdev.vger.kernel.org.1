Return-Path: <netdev+bounces-40895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19B47C9159
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E31C209AD
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9A82C867;
	Fri, 13 Oct 2023 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hMkPp69E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927F2C863
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 23:35:11 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8E6B7
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:35:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso434878b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697240107; x=1697844907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AHKDZ3XDgz4acF4+DkWVpvMtmbGAqaQVvgAwz4bhM4Y=;
        b=hMkPp69EStD3kWejd2MFFyrqD8k4pHKRS01+GAz7TEJNyhXN22W6XfcVVJLcx/2YNP
         VJZAmTy+m0Oh8AhllsOLmuRI+z+ai7O+7G211JVeSmRhEL+BRQqNTilRO3XWl+1r1YGn
         EI05wdZ6Pq/u7CigRzSZnsNGu5VClhMND5LEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240107; x=1697844907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHKDZ3XDgz4acF4+DkWVpvMtmbGAqaQVvgAwz4bhM4Y=;
        b=gbQuqDLl7KLlEbYFeGdr2JbdaSGCUEDrJNwtrf8JsQixPerM+3oQI8OOQvnJKnPEqT
         bpTvgW8fDp7iPs37uLJ3SLCFEkmMiaR6OA7E/iC2VpxoBCZEs/9DBAHZ2kZ/XqIBwZJm
         E8WZSJ+4vTjT8/FTNfAFw6blKLWIuy6qmqgPZV2ZGGwvINh/FBU4t1K97T/Iarj2gJqV
         L6N7Gg4WN4lwZYYgPTLz9JDp7tYXNTbIs7Vooodlm1ZBosQ/y16yAO8BgJ9HXLsokw64
         4G86nluSkCvDybOdynoU/ZFMKjlJ8gnOgIMOdGf6CjoaH8Y+490JnehgyWZwkPRE6HcF
         RL/w==
X-Gm-Message-State: AOJu0Yy3IJJasZTCfANQ2OwCh2IlmBna9Ke6bHBCVoA8DiBxmrshnxPk
	ObPgtOKXYcZ55NTk1guvm15MeQ==
X-Google-Smtp-Source: AGHT+IFVsRqeEvvb0rxG9AitDSaFC9Eo2vYmuaEaLBSRUAgTIHFNojLc8fnR5monzQ6HhXkXFzrFKg==
X-Received: by 2002:a62:8492:0:b0:68a:582b:6b62 with SMTP id k140-20020a628492000000b0068a582b6b62mr1709607pfd.7.1697240107470;
        Fri, 13 Oct 2023 16:35:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y16-20020aa793d0000000b0068fdb59e9d6sm668511pff.78.2023.10.13.16.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:35:06 -0700 (PDT)
Date: Fri, 13 Oct 2023 16:35:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310131630.5E435AD@keescook>
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch>
 <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
 <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
 <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8qcLARQ4GEabEvcD=HmLdikgP6J82VdT=A9hLTDNru0LQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 02:23:34PM -0700, Justin Stitt wrote:
> On Fri, Oct 13, 2023 at 2:12 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > On Fri, Oct 13, 2023 at 1:13 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Fri, Oct 13, 2023 at 12:53:53PM -0700, Justin Stitt wrote:
> > > > On Fri, Oct 13, 2023 at 5:22 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > > > >
> > > > > > -     for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > > > > > -             strncpy(data + i * ETH_GSTRING_LEN,
> > > > > > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > > > > > -     }
> > > > > > +     for (i = 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > > > > > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
> > > > > >  }
> > > > >
> > > > > I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> > > > > be trusted as a format string? Is this indicating we need an
> > > > > ethtool_puts() ?
> > > >
> > > > Indeed, it would trigger a -Wformat-security warning.
> > > >
> > > > An ethtool_puts() would be useful for this situation.
> > >
> > > Hi Justin
> > >
> > > hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, netvsc_stats[i].name);
> > > hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, vf_stats[i].name);
> > > ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_gstrings_priv_flags[i].flag_string);
> > > ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
> > > ethernet/intel/ice/ice_ethtool.c:                       ethtool_sprintf(&p, ice_gstrings_priv_flags[i].name);
> > > ethernet/intel/igc/igc_ethtool.c:                       ethtool_sprintf(&p, igc_gstrings_stats[i].stat_string);
> > > ethernet/intel/ixgbe/ixgbe_ethtool.c:                   ethtool_sprintf(&p, ixgbe_gstrings_test[i]);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:                       ethtool_sprintf(&data, nfp_self_test[i].name);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
> > > ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&data, nfp_net_et_stats[i].name);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, txq_stat_names[j]);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, xdpq_stat_names[j]);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, rxq_stat_names[j]);
> > > ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_sprintf(&p, tls_stat_names[j]);
> > > ethernet/amazon/ena/ena_ethtool.c:              ethtool_sprintf(&data, ena_stats->name);
> > > ethernet/amazon/ena/ena_ethtool.c:                      ethtool_sprintf(&data, ena_stats->name);
> > > ethernet/brocade/bna/bnad_ethtool.c:            ethtool_sprintf(&string, bnad_net_stats_strings[i]);
> > > ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
> > > ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
> > > ethernet/hisilicon/hns/hns_dsaf_gmac.c:         ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
> > > ethernet/hisilicon/hns/hns_dsaf_xgmac.c:                ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
> > > vmxnet3/vmxnet3_ethtool.c:              ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
> > >
> >
> > Woah, are these all triggering -Wformat-security warnings?
> 
> Erhm, I guess -Wformat-security is turned off:
> 
> ./scripts/Makefile.extrawarn +16:
> KBUILD_CFLAGS += -Wno-format-security

Whee. This is a longer issue, but yes, it would be nice if we could get
out of the way of enabling -Wformat-security again some day.

> Kees, what do you think about this warning and the semantics of:
> 
> 1) ethtool_sprintf(&data, "%s", some[i].string);
> 2) ethtool_sprintf(&data, some[i].string);
> 3) ethtool_puts(&data, some[i].string);

I've been told that this whole ethtool API area is considered
deprecated. If that holds, then I don't think it's worth adding new
helpers to support it when ethtool_sprintf() is sufficient.

Once you're done with the strncpy->ethtool_sprintf conversions I think
it would be nice to have a single patch that fixes all of these
"%s"-less instances to use "%s". (Doing per-driver fixes for that case
seems just overly painful.)

-- 
Kees Cook

