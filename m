Return-Path: <netdev+bounces-14236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553873FB45
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 13:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8704A1C208EB
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670401775A;
	Tue, 27 Jun 2023 11:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD010F9
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 11:41:54 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E57102;
	Tue, 27 Jun 2023 04:41:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98e109525d6so528158466b.0;
        Tue, 27 Jun 2023 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687866111; x=1690458111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLCPa6nZQpfPgSc4juymFKG8/hs+ZrwGVBkAUJ3rTuc=;
        b=CVJ860h2ZOdFWZmQWFaZ2hwikkPWxh3VLPLwpmYMq+YkC6He/p0IMJ06XEDR3ausYm
         KdE8UDNEILn0UtI1mp7SG6nRLAWrpKNzcvV4E3QOgsd20b6xYsxDMh+zHLEbi2jMuf4j
         sRdAoVRj1fJndbTKFHsyfPoyT+hOCNf2ykVpMfT5WfiezYvLdXBzEVSstrotXZpdxjD0
         jnomQ0jmmhiQaW//XoY7MDjkoO9VsZTws/7cd6+JBDRjgrjzqdfSNXubXJ1tS+WierDU
         XrXX5ldQePOSNQdIoukUrSkW7p2pQ2SteInIiw0cR2VwmpKWEXpSx8VEjv+no8FOPuq7
         L9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866111; x=1690458111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLCPa6nZQpfPgSc4juymFKG8/hs+ZrwGVBkAUJ3rTuc=;
        b=Dh35mFL14SyadhxmEcS3JG6a9W+l8FCS0q4rZclLa0qDCOzAVzK2c/U0LT4oIpanj6
         04D0zNnHj05ZPhRRGsilGdJOncD5D8bSY2JG6JdASvdh9TRh0qMrRbzvi9AeBC1PbYMN
         sIAn2mkSx9GEWsorZxXNtjUPWhRklKzQt+qOGPpplnrTTFsz/aDVgQV2+WVXTXYjFGK7
         Te5vJT/wl/9V1JM2l9q6A1e0jNlR0njMYdphqPJzY7IslndV+0jvh+fiGqNuYGF1qvbk
         5IRrGCuw9e1FX4+CK72JkG9H49oWaLB7UuoTMfvoO4axce13n26hKjKxaTqDr2El4cbF
         Qvyw==
X-Gm-Message-State: AC+VfDyX75OrBexAyueZWs6R5PGI07b7uVygJvwuF+EzaWBxMuEGdHfQ
	/I88a2z03dUphwpuDB8B2UA=
X-Google-Smtp-Source: ACHHUZ7QiODMRguTr8XLYLEPD3zMhNk0nlbKYbHkig1slCbMG0v0CLvxHru68Xziqg2mx+Xi6aLm6w==
X-Received: by 2002:a17:907:6e06:b0:98f:8481:24b3 with SMTP id sd6-20020a1709076e0600b0098f848124b3mr6264974ejc.37.1687866110530;
        Tue, 27 Jun 2023 04:41:50 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id ha22-20020a170906a89600b0098e0c0cfb66sm3869302ejb.38.2023.06.27.04.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:41:50 -0700 (PDT)
Date: Tue, 27 Jun 2023 14:41:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: tag_sja1105: always prefer source port
 information from INCL_SRCPT
Message-ID: <20230627114148.lpyopy6ttuvvciww@skbuf>
References: <20230626155112.3155993-1-vladimir.oltean@nxp.com>
 <20230626155112.3155993-3-vladimir.oltean@nxp.com>
 <ZJnU6WntVQW2AgvZ@corigine.com>
 <20230626221828.qzjeo6dedjnyme6k@skbuf>
 <ZJrEtw15g3a7nyLN@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJrEtw15g3a7nyLN@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 01:15:03PM +0200, Simon Horman wrote:
> On Tue, Jun 27, 2023 at 01:18:28AM +0300, Vladimir Oltean wrote:
> > Hi Simon,
> > 
> > On Mon, Jun 26, 2023 at 08:11:53PM +0200, Simon Horman wrote:
> > > Hi Vladimir,
> > > 
> > > A similar comment to that made for [1], though the code is somewhat
> > > different to that case: are you sure vid is initialised here?
> > > GCC 12 and Smatch seem unsure about it.
> > > 
> > > [1] Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based on 8021q
> > >     https://lore.kernel.org/all/ZJg2M+Qvg3Fv73CH@corigine.com/
> > 
> > "vid" can be uninitialized if the tagger is fed a junk packet (a
> > non-link-local, non-meta packet that also has no tag_8021q header).
> > 
> > The immediate answer that comes to mind is: it depends on how the driver
> > configures the hardware to send packets to the CPU (and it will never
> > configure the switch in that way).
> > 
> > But, between the sja1105 driver configuring the switch in a certain way
> > and the tag_sja1105 driver seeing the results of that, there's also the
> > DSA master driver (can be any net_device) which can alter the packet in
> > a nonsensical way, like remove the VLAN header for some reason.
> > 
> > Considering the fact that the DSA master can have tc rules on its
> > ingress path which do just that, it would probably be wise to be
> > defensive about this. So I can probably add:
> > 
> > 	if (sja1105_skb_has_tag_8021q(skb)) {
> > 		... // existing call to sja1105_vlan_rcv() here
> > 	} else if (source_port == -1 && switch_id == -1) {
> > 		/* Packets with no source information have no chance of
> > 		 * getting accepted, drop them straight away.
> > 		 */
> > 		return NULL;
> > 	}
> > 
> > This "else if" block should ensure that when "vid" is uninitialized,
> > either "source_port" and "switch_id", or "vbid", always have valid values.
> 
> This is kind of complex :)
> 
> Can I clarify that either:
> 
> 1. Both source_port and switch_id are -1; or
> 2. Neither source_port nor switch_id are -1
> 
> If so, I agree with your proposal.

They are integers assigned from the same code blocks in all cases,
starting with -1 and later being assigned rvalues either from u64 fields
limited to 0-255 (meta->source_port, meta->switch_id) or from unsigned
char fields (hdr->h_dest[3], hdr->h_dest[4]), or from
dsa_8021q_rx_source_port() and dsa_8021q_rx_switch_id() which return
limited-size positive integers due to their implementation.

