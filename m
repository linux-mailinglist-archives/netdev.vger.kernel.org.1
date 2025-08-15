Return-Path: <netdev+bounces-213944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A5B276C2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D946016179D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F129D26C;
	Fri, 15 Aug 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="537fBxO9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD3294A0C;
	Fri, 15 Aug 2025 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228511; cv=none; b=Ocalkub6XmenhvLQWzAexIB+1Df1tpeH1D4rkDZg6y4yb8K5XpsaG9j5u69S/JbJCazQWG/g9kxGR83VAP7L3YUW7QtdHxW03Hl0FrO/KP03rWxKV56wvLqtnc332b9QknVaIDuVgH4iHCZsbModST9E8iaITue72b2FftqJ28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228511; c=relaxed/simple;
	bh=jP7e9gn+a58ccJpt8demjh1kQTTOHU0Vnk0gVqye3Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mks/3F72RB0mhW16Px6iyzpcbofoPv9Zu2c8Tnzd/mNMEPVDAkzBhAC2W/ogDkJbukkY34VeihqZobApVZR0gGcY5st5wHTTeg7R0FpdyzyaOTRanBFm1/0EFO+9KE5DhiFh4CGA/JwWYCUQX2mtwseGZv+gOK8Zur2iqH4JD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=537fBxO9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KxAb8RxFweq9QIxQUe5FSbZG2FwtLiTAM5boIcfZmVQ=; b=537fBxO9uwxRtKsvaMBppAQ1+R
	LkBciKbHhmQWd08WwVbTCa/R3YAJ2aJH9h5KVNcWABhr0dIjXs8+mx6PDYrP1zS8yjEDVaDtm81jr
	Y0TD2geKuBPbfLyP3gBjRGWS63wnbZykvDO+apMvmc9lgICBkEVQ3yfyDeI0Lsy5JD1k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uml6d-004mUP-Q0; Fri, 15 Aug 2025 05:27:51 +0200
Date: Fri, 15 Aug 2025 05:27:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <eebc7ed8-f6c5-4095-b33e-251411f26f0a@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814073855.1060601-5-dong100@mucse.com>

>  struct mucse_hw {
> +	u8 pfvfnum;
>  	void __iomem *hw_addr;
>  	void __iomem *ring_msix_base;
>  	struct pci_dev *pdev;
> +	u32 fw_version;
> +	u32 axi_mhz;
> +	u32 bd_uid;
>  	enum rnpgbe_hw_type hw_type;
>  	struct mucse_dma_info dma;
>  	struct mucse_eth_info eth;

Think about alignment of these structures. The compiler is going to
put in padding after the u8 phvfnum. The 3 pointers are all the same
size, no padding. The u32 probably go straight after the pointers. The
enum it might represent as a single byte, so there is will be padding
before dma. So consider moving the u8 next to the enum.

pahole(1) will tell you what the compiler really did, but you will
find more experienced engineers try to minimise padding, or
deliberately group hot items on a cache line, and document that.

> +static int mucse_fw_send_cmd_wait(struct mucse_hw *hw,
> +				  struct mbx_fw_cmd_req *req,
> +				  struct mbx_fw_cmd_reply *reply)
> +{
> +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> +	int retry_cnt = 3;
> +	int err;
> +
> +	err = mutex_lock_interruptible(&hw->mbx.lock);
> +	if (err)
> +		return err;
> +	err = hw->mbx.ops->write_posted(hw, (u32 *)req,
> +					L_WD(len));

This L_WD macro is not nice. It seems like a place bugs will be
introduced, forgetting to call it here. Why not have write_posted()
take bytes, and have the lowest layer convert to 32 bit words.

It also seems odd you are adding MBX_REQ_HDR_LEN here but not that
actual header. Why not increase the length at the point the header is
actually added? Keep stuff logically together.

> +	if (err)
> +		goto quit;
> +	do {
> +		err = hw->mbx.ops->read_posted(hw, (u32 *)reply,
> +					       L_WD(sizeof(*reply)));
> +		if (err)
> +			goto quit;
> +	} while (--retry_cnt >= 0 && reply->opcode != req->opcode);
> +quit:

Maybe add some documentation about what is actually going on here. I
assume you are trying to get the driver and firmware into sync after
one or other has crashed, burned, and rebooted. You need to flush out
old replies. You allow up to three old replies to be in the queue, and
then give up. Since you don't retry the write, you don't expect writes
to be lost?


> +	mutex_unlock(&hw->mbx.lock);
> +	if (!err && retry_cnt < 0)
> +		return -ETIMEDOUT;
> +	if (!err && reply->error_code)
> +		return -EIO;
> +	return err;
> +}
> +
> +/**
> + * mucse_fw_get_capability - Get hw abilities from fw
> + * @hw: pointer to the HW structure
> + * @abil: pointer to the hw_abilities structure
> + *
> + * mucse_fw_get_capability tries to get hw abilities from
> + * hw.
> + *
> + * @return: 0 on success, negative on failure
> + **/
> +static int mucse_fw_get_capability(struct mucse_hw *hw,
> +				   struct hw_abilities *abil)
> +{
> +	struct mbx_fw_cmd_reply reply = {};
> +	struct mbx_fw_cmd_req req = {};
> +	int err;
> +
> +	build_phy_abilities_req(&req, &req);

Passing the same parameter twice? Is that correct? It looks very odd.

> +/**
> + * mbx_cookie_zalloc - Alloc a cookie structure
> + * @priv_len: private length for this cookie
> + *
> + * @return: cookie structure on success
> + **/
> +static struct mbx_req_cookie *mbx_cookie_zalloc(int priv_len)
> +{
> +	struct mbx_req_cookie *cookie;
> +
> +	cookie = kzalloc(struct_size(cookie, priv, priv_len), GFP_KERNEL);
> +	if (cookie) {
> +		cookie->timeout_jiffes = 30 * HZ;
> +		cookie->magic = COOKIE_MAGIC;
> +		cookie->priv_len = priv_len;
> +	}
> +	return cookie;

> +struct mbx_req_cookie {
> +	int magic;
> +#define COOKIE_MAGIC 0xCE
> +	cookie_cb cb;
> +	int timeout_jiffes;
> +	int errcode;
> +	wait_queue_head_t wait;
> +	int done;
> +	int priv_len;
> +	char priv[];
> +};


Using struct_size() makes me think this is supposed to be a flexible
array? I've never used them myself, but shouldn't be some markup so
the compiler knows priv_len is the len of priv?

> +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> +				 struct mbx_fw_cmd_req *req,
> +				 struct mbx_req_cookie *cookie)
> +{
> +	int len = le16_to_cpu(req->datalen) + MBX_REQ_HDR_LEN;
> +	int err;
> +
> +	cookie->errcode = 0;
> +	cookie->done = 0;
> +	init_waitqueue_head(&cookie->wait);
> +	err = mutex_lock_interruptible(&hw->mbx.lock);
> +	if (err)
> +		return err;
> +	err = mucse_write_mbx(hw, (u32 *)req,
> +			      L_WD(len));
> +	if (err) {
> +		mutex_unlock(&hw->mbx.lock);

Please try to put the unlock at the end of the function, with a goto
on error.

> +		return err;
> +	}
> +	do {
> +		err = wait_event_interruptible_timeout(cookie->wait,
> +						       cookie->done == 1,
> +						       cookie->timeout_jiffes);
> +	} while (err == -ERESTARTSYS);

This needs a comment, because i don't understand it.


> +	mutex_unlock(&hw->mbx.lock);
> +	if (!err)
> +		err = -ETIME;

I _think_ ETIMEDOUT would be more normal.

> +	else
> +		err = 0;
> +	if (!err && cookie->errcode)
> +		err = cookie->errcode;
> +
> +	return err;
> +}
> +int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
> +			 u8 *mac_addr,
> +			 int lane)
> +{
> +	struct mbx_fw_cmd_reply reply = {};
> +	struct mbx_fw_cmd_req req = {};
> +	int err;
> +
> +	build_get_macaddress_req(&req, 1 << lane, pfvfnum, &req);
> +	err = mucse_fw_send_cmd_wait(hw, &req, &reply);
> +	if (err)
> +		return err;
> +
> +	if ((1 << lane) & le32_to_cpu(reply.mac_addr.lanes))

BIT(). And normally the & would be the other way around.

What exactly is a lane here? Normally we would think of a lane is
-KR4, 4 SERDES lanes making one port. But the MAC address is a
property of the port, not the lane within a port.

> +		memcpy(mac_addr, reply.mac_addr.addrs[lane].mac, 6);

There is a macro for 6, please use it.

> +struct hw_abilities {
> +	u8 link_stat;
> +	u8 lane_mask;
> +	__le32 speed;
> +	__le16 phy_type;
> +	__le16 nic_mode;
> +	__le16 pfnum;

Another example of a bad structure layout. It would of been much
better to put the two u8 after speed.

> +} __packed;

And because this is packed, and badly aligned, you are forcing the
compiler to do a lot more work accessing these members.

> +
> +static inline void ability_update_host_endian(struct hw_abilities *abi)
> +{
> +	u32 host_val = le32_to_cpu(abi->ext_ability);
> +
> +	abi->e_host = *(typeof(abi->e_host) *)&host_val;
> +}

Please add a comment what this is doing, it is not obvious.


> +
> +#define FLAGS_DD BIT(0)
> +#define FLAGS_ERR BIT(2)
> +
> +/* Request is in little-endian format. Big-endian systems should be considered */

So the code now sparse clean? If it is, you can probably remove this
comment.

> +static inline void build_phy_abilities_req(struct mbx_fw_cmd_req *req,
> +					   void *cookie)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(GET_PHY_ABALITY);
> +	req->datalen = 0;
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +	req->cookie = cookie;
> +}
> +
> +static inline void build_ifinsmod(struct mbx_fw_cmd_req *req,
> +				  unsigned int lane,
> +				  int status)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(DRIVER_INSMOD);
> +	req->datalen = cpu_to_le16(sizeof(req->ifinsmod));
> +	req->cookie = NULL;
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +	req->ifinsmod.lane = cpu_to_le32(lane);
> +	req->ifinsmod.status = cpu_to_le32(status);
> +}
> +
> +static inline void build_reset_phy_req(struct mbx_fw_cmd_req *req,
> +				       void *cookie)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(RESET_PHY);
> +	req->datalen = 0;
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +	req->cookie = cookie;
> +}
> +
> +static inline void build_get_macaddress_req(struct mbx_fw_cmd_req *req,
> +					    int lane_mask, int pfvfnum,
> +					    void *cookie)
> +{
> +	req->flags = 0;
> +	req->opcode = cpu_to_le16(GET_MAC_ADDRES);
> +	req->datalen = cpu_to_le16(sizeof(req->get_mac_addr));
> +	req->cookie = cookie;
> +	req->reply_lo = 0;
> +	req->reply_hi = 0;
> +	req->get_mac_addr.lane_mask = cpu_to_le32(lane_mask);
> +	req->get_mac_addr.pfvf_num = cpu_to_le32(pfvfnum);
> +}

These are rather large for inline functions in a header. Please move
them into a .c file.

	Andrew

