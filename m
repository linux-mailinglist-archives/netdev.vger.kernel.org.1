Return-Path: <netdev+bounces-179743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E9AA7E6AA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B6C420D5D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797B20E31E;
	Mon,  7 Apr 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6RcwSKf"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15220DD5A
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043031; cv=none; b=orhqI1sLWP3LzJsC88KIPPAKA/HBa+7AXL8ihQ0A1u1/4+DHqeLKBBWTjctY2uVTJ2tgPIdXa5WRoMnAenLbLfaEv1yBcJdvxGk9sX/5r6dDmTWicuPtxdXxWuqs3Y20HrehTi2tEntFsWE7o8WIvLwv6br7MZYetfGwNZUAkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043031; c=relaxed/simple;
	bh=hH3BygcqR2X80d2WDb51iDfTxBHWvD5bURws5mUKaY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDwX+8nTTKUqRTR/b5ZIN+DMVE1627FHzIqeAVNg1a9Hmzvrh2pX7dDCzQz0eXDrngYz4neHyMQwNwqlMVlO0ZJ3VDPyB2i9pJmwQc/SafD+4Yl+mMXIVs9/qVBYwmw45lnPxnXqTFmnpwQluXUf7kGAPMX4lCOUQbZbLNNWlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6RcwSKf; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BC2571380213;
	Mon,  7 Apr 2025 12:23:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 12:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744043028; x=1744129428; bh=dC6YzEVR2i8QLwi27ybVkevSY24EdTkXS4i
	T3Z7X2t8=; b=a6RcwSKfE9+9rzL6H4tnZdkzBUUxW1gE2eU2yYPLxUsa+mQttru
	wOCJafZi1KEjV4Hhp3K2j1KLrwckd87hJTYfI61pzt8hfZb2srnMNwibFlggj6/7
	oYSXIeFFylCPPtt2umkpnUmjaJ6MzBDbgZ/1+g9fahY+BCBY5ROhj9tU35RWMw2b
	gTuGxE0tDwTVuqK43t+wX2IwhLpcrY8FrErOG/LoSa9uCwAdgLt6n8zl5rPRRzKQ
	68lCOWsgeXUZHCPn8prSN2ZtINaWqHYUjB1X/5kNE4WqRMg8Vq98PJxATOqTklsl
	eEHmbXssYG49cOyJnnYjyycPL9FEzLY+R0w==
X-ME-Sender: <xms:FPzzZ_rQnC5iOd0NU6oUGwk-g82xK6dRj9jrm7sZD-EXDSaRIdsstA>
    <xme:FPzzZ5qy83ZELTYZamtwGravTivRHIVdfUxhgbR8z2aWSOrSzuOTJqpoSUXV_5MBT
    R2UmfYsOcitHeI>
X-ME-Received: <xmr:FPzzZ8O_kcHHSaSpBrxZPweSyyqP_6djcQb4VSGC4k8Hl-a4dqgf7bxHh0ZJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghmohguhhgrrh
    grmhdrrghmmhgvphgrlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepmhhi
    tghhrggvlhdrtghhrghnsegsrhhorggutghomhdrtghomhdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrd
    gthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FPzzZy5E_4N-RH17hnKwZKwJAFM6eXdrWAbFlpBbZ9exkxrxiHVWug>
    <xmx:FPzzZ-4fnYU2QUcfzCsW9rMSkkS5nDpJGkcluLR32nsA9xCqbLHZkQ>
    <xmx:FPzzZ6gI5WLcuR5lGyhyXaTTisJmEjOxCg_7_KUWYaAVUWtsDrGWSQ>
    <xmx:FPzzZw4xyf5k3CuUN3vohQce0uP8ndbbGO_jkMyDiltNgddiqlZEkw>
    <xmx:FPzzZ5AkVtYLavHmN-l_0KNAKWpiOuFQ0PicLFD1fd7tHd6qKvrl10SX>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 12:23:47 -0400 (EDT)
Date: Mon, 7 Apr 2025 19:23:45 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, horms@kernel.org,
	danieller@nvidia.com, andrew.gospodarek@broadcom.com,
	petrm@nvidia.com
Subject: Re: [PATCH net 2/2] ethtool: cmis: use u16 for calculated
 read_write_len_ext
Message-ID: <Z_P8EZ4YPISzAbPw@shredder>
References: <20250402183123.321036-1-michael.chan@broadcom.com>
 <20250402183123.321036-3-michael.chan@broadcom.com>
 <Z-6jN7aA8ZnYRH6j@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-6jN7aA8ZnYRH6j@shredder>

On Mon, Apr 07, 2025 at 08:09:56AM -0700, Damodharam Ammepalli wrote:
> From: Ido Schimmel <idosch@idosch.org>
> 
> Adding Petr given Danielle is away
> 
> On Wed, Apr 02, 2025 at 11:31:23AM -0700, Michael Chan wrote:
> > From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> > 
> > For EPL (Extended Payload), the maximum calculated size returned by
> > ethtool_cmis_get_max_epl_size() is 2048, so the read_write_len_ext
> > field in struct ethtool_cmis_cdb_cmd_args needs to be changed to u16
> > to hold the value.
> > 
> > To avoid confusion with other u8 read_write_len_ext fields defined
> > by the CMIS spec, change the field name to calc_read_write_len_ext.
> > 
> > Without this change, module flashing can fail:
> > 
> > Transceiver module firmware flashing started for device enp177s0np0
> > Transceiver module firmware flashing in progress for device enp177s0np0
> > Progress: 0%
> > Transceiver module firmware flashing encountered an error for device enp177s0np0
> > Status message: Write FW block EPL command failed, LPL length is longer
> > 	than CDB read write length extension allows.
> > 
> > Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands)
> > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> >  net/ethtool/cmis.h     | 7 ++++---
> >  net/ethtool/cmis_cdb.c | 8 ++++----
> >  2 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
> > index 1e790413db0e..51f5d5439e2a 100644
> > --- a/net/ethtool/cmis.h
> > +++ b/net/ethtool/cmis.h
> > @@ -63,8 +63,9 @@ struct ethtool_cmis_cdb_request {
> >   * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
> >   * @req: CDB command fields as described in the CMIS standard.
> >   * @max_duration: Maximum duration time for command completion in msec.
> > - * @read_write_len_ext: Allowable additional number of byte octets to the LPL
> > - *			in a READ or a WRITE commands.
> > + * @calc_read_write_len_ext: Calculated allowable additional number of byte
> > + *			     octets to the LPL or EPL in a READ or WRITE CDB
> > + *			     command.
> >   * @msleep_pre_rpl: Waiting time before checking reply in msec.
> >   * @rpl_exp_len: Expected reply length in bytes.
> >   * @flags: Validation flags for CDB commands.
> > @@ -73,7 +74,7 @@ struct ethtool_cmis_cdb_request {
> >  struct ethtool_cmis_cdb_cmd_args {
> >  	struct ethtool_cmis_cdb_request req;
> >  	u16				max_duration;
> > -	u8				read_write_len_ext;
> > +	u16				calc_read_write_len_ext;
> >  	u8				msleep_pre_rpl;
> >  	u8                              rpl_exp_len;
> >  	u8				flags;
> > diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
> > index dba3aa909a95..1f487e1a6347 100644
> > --- a/net/ethtool/cmis_cdb.c
> > +++ b/net/ethtool/cmis_cdb.c
> > @@ -35,13 +35,13 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
> >  	args->req.lpl_len = lpl_len;
> >  	if (lpl) {
> >  		memcpy(args->req.payload, lpl, args->req.lpl_len);
> > -		args->read_write_len_ext =
> > +		args->calc_read_write_len_ext =
> >  			ethtool_cmis_get_max_lpl_size(read_write_len_ext);
> >  	}
> >  	if (epl) {
> >  		args->req.epl_len = cpu_to_be16(epl_len);
> >  		args->req.epl = epl;
> > -		args->read_write_len_ext =
> > +		args->calc_read_write_len_ext =
> >  			ethtool_cmis_get_max_epl_size(read_write_len_ext);
> 
> AFAIU, a size larger than a page (128 bytes) is only useful when auto
> paging is supported which is something the kernel doesn't currently
> support. Therefore, I think it's misleading to initialize this field to
> a value larger than 128.
> 
> How about deleting ethtool_cmis_get_max_epl_size() and moving the
> initialization of 'args->read_write_len_ext' outside of the if block as
> it was before 9a3b0d078bd82?
> 
> >  	}
> >  
> > @@ -590,7 +590,7 @@ ethtool_cmis_cdb_execute_epl_cmd(struct net_device *dev,
> >  			space_left = CMIS_CDB_EPL_FW_BLOCK_OFFSET_END - offset + 1;
> >  			bytes_to_write = min_t(u16, bytes_left,
> >  					       min_t(u16, space_left,
> > -						     args->read_write_len_ext));
> > +						     args->calc_read_write_len_ext));
> >  
> >  			err = __ethtool_cmis_cdb_execute_cmd(dev, page_data,
> >  							     page, offset,
> > @@ -631,7 +631,7 @@ int ethtool_cmis_cdb_execute_cmd(struct net_device *dev,
> >  				       offsetof(struct ethtool_cmis_cdb_request,
> >  						epl));
> >  
> > -	if (args->req.lpl_len > args->read_write_len_ext) {
> > +	if (args->req.lpl_len > args->calc_read_write_len_ext) {
> >  		args->err_msg = "LPL length is longer than CDB read write length extension allows";
> >  		return -EINVAL;
> >  	}
> > -- 
> > 2.30.1
> > 
> > 
> 
> This module supports AutoPaging, 255 read_write_len_ext and EPL write mechanism.
> This advertised 0xff (byte2) calculates the args->read_write_len_ext
> to 2048B, which needs u16.
> Hexdump: cmis_cdb_advert_rpl
> Off 0x00 :77 ff 1f 80
> 
> With your suggested change, ethtool_cmis_cdb_execute_epl_cmd() is skipped
> since args->req.epl_len is set to zero and download fails.

To be clear, this is what I'm suggesting [1] and it doesn't involve
setting args->req.epl_len to zero, so I'm not sure what was tested.

Basically, setting maximum length of read or write to 128 bytes as the
kernel does not currently support auto paging (even if the transceiver
module does) and will not try to perform cross-page reads or writes.

[1]
diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 1e790413db0e..4a9a946cabf0 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -101,7 +101,6 @@ struct ethtool_cmis_cdb_rpl {
 };
 
 u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs);
-u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs);
 
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lpl,
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index d159dc121bde..0e2691ccb0df 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -16,15 +16,6 @@ u32 ethtool_cmis_get_max_lpl_size(u8 num_of_byte_octs)
 	return 8 * (1 + min_t(u8, num_of_byte_octs, 15));
 }
 
-/* For accessing the EPL field on page 9Fh, the allowable length extension is
- * min(i, 255) byte octets where i specifies the allowable additional number of
- * byte octets in a READ or a WRITE.
- */
-u32 ethtool_cmis_get_max_epl_size(u8 num_of_byte_octs)
-{
-	return 8 * (1 + min_t(u8, num_of_byte_octs, 255));
-}
-
 void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 				   enum ethtool_cmis_cdb_cmd_id cmd, u8 *lpl,
 				   u8 lpl_len, u8 *epl, u16 epl_len,
@@ -33,19 +24,16 @@ void ethtool_cmis_cdb_compose_args(struct ethtool_cmis_cdb_cmd_args *args,
 {
 	args->req.id = cpu_to_be16(cmd);
 	args->req.lpl_len = lpl_len;
-	if (lpl) {
+	if (lpl)
 		memcpy(args->req.payload, lpl, args->req.lpl_len);
-		args->read_write_len_ext =
-			ethtool_cmis_get_max_lpl_size(read_write_len_ext);
-	}
 	if (epl) {
 		args->req.epl_len = cpu_to_be16(epl_len);
 		args->req.epl = epl;
-		args->read_write_len_ext =
-			ethtool_cmis_get_max_epl_size(read_write_len_ext);
 	}
 
 	args->max_duration = max_duration;
+	args->read_write_len_ext =
+		ethtool_cmis_get_max_lpl_size(read_write_len_ext);
 	args->msleep_pre_rpl = msleep_pre_rpl;
 	args->rpl_exp_len = rpl_exp_len;
 	args->flags = flags;

