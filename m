Return-Path: <netdev+bounces-37918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB2A7B7CE4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id DE24AB207D7
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1F11193;
	Wed,  4 Oct 2023 10:14:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44649883D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:14:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B783
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696414479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iCGNMhLhtxoCMrWMD8suopdcDwmtDizUXoNxQu9mGP8=;
	b=TfpMZMoSGGPV+P8rIVAgXKIvA42koGtRVEBRycDsAjFVh5XirtBKhE6scO7EYEJelQU6C9
	E1cJKonrIdzzg7cQ71pWqM1pKXbMnV7C644idLpw/nMfEyQ7ipJZnWqcOOYBDyA+F+uvvP
	abWr0Lcf2yFDggH3YpqB+gN8Jdn+Qs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-9p8XUA5oPCWvantsnBpEJQ-1; Wed, 04 Oct 2023 06:14:37 -0400
X-MC-Unique: 9p8XUA5oPCWvantsnBpEJQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31fd48da316so1374842f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 03:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696414476; x=1697019276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCGNMhLhtxoCMrWMD8suopdcDwmtDizUXoNxQu9mGP8=;
        b=XbMEMigWYJGynNYpH70K5GwTG1OE0fMxDePIfYZUJRnx5ivn5DV/9hLRLgk2R1waa3
         xFIsmkBcs//I4BsBfrwHpIRGftE1Y61du7LRDIMyayZBPReR5Q2l76s6BFJ/HTyVWxxp
         uMx5ya5PcH3s6Ii/MNReLvarqqWL59hWedbiCPlJJTEtV3vAGo2pNzVGQPu4A5A3Xvih
         XnDBz+QuDLTWixovPABZrruryZL+dM8t8etTNn3KY9degQbyRukwNpF9kfxUAtNeEJHg
         Wk5qYN3R+Nn1Ah77QJGFq7BpXOVbInQggaeWO+ERYZfWYmC6ycgNt+EKEynnOMLOYwOJ
         8LJw==
X-Gm-Message-State: AOJu0Yyoul+HHPqH/rMj37G6FQRVgwnzevBss0tp42hvut00evTee1LS
	1r18GZTItdL1JVlKC82DbtcmrkZSHmqGzwd7f3ixFVeUd1ZEt/6qrWTPWcYao6pzjt5RA3u4I6l
	IBWxIXsF6VGNJd6Iv
X-Received: by 2002:adf:fdc7:0:b0:320:c9c8:5f14 with SMTP id i7-20020adffdc7000000b00320c9c85f14mr1766424wrs.29.1696414476552;
        Wed, 04 Oct 2023 03:14:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgqCfzcp7lgnQ4mRrXU8GGUEl4a/20nuQHjlAGldYtxr1PFow9zvPoCUS2lnd2/W1QIwX6hw==
X-Received: by 2002:adf:fdc7:0:b0:320:c9c8:5f14 with SMTP id i7-20020adffdc7000000b00320c9c85f14mr1766407wrs.29.1696414476209;
        Wed, 04 Oct 2023 03:14:36 -0700 (PDT)
Received: from localhost (net-93-66-52-16.cust.vodafonedsl.it. [93.66.52.16])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d5307000000b003217c096c1esm3637595wrv.73.2023.10.04.03.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:14:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:14:33 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZR07CYtL8GwMQQPV@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
 <20231003110358.4a08b826@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bviZ5Xg+0CkFD4tl"
Content-Disposition: inline
In-Reply-To: <20231003110358.4a08b826@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--bviZ5Xg+0CkFD4tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 11 Sep 2023 14:49:46 +0200 Lorenzo Bianconi wrote:
> > +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
> > +			  &nfsd_server_nl_family, NLM_F_MULTI,
> > +			  NFSD_CMD_RPC_STATUS_GET);
> > +	if (!hdr)
> > +		return -ENOBUFS;
>=20
> Why NLM_F_MULTI? AFAIU that means "I'm splitting one object over
> multiple messages". 99% of the time the right thing to do is change=20
> what we consider to be "an object" rather than do F_MULTI. In theory
> user space should re-constitute all the NLM_F_MULTI messages into as
> single object, which none of YNL does today :(
>=20
ack, fine. I think we can get rid of it.
@chuck: do you want me to send a patch or are you taking care of it?

Regards,
Lorenzo

--bviZ5Xg+0CkFD4tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZR07CQAKCRA6cBh0uS2t
rMbyAQDdl3098e/PoDusNCKv71zSKsaMiEZt/jv+k9NY/c6YhQEAnu8agwVUV6CY
OTlChJGKZzOxcbzaEX/D4YdQ6v/Gqgc=
=kW31
-----END PGP SIGNATURE-----

--bviZ5Xg+0CkFD4tl--


