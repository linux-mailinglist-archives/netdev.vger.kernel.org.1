Return-Path: <netdev+bounces-305373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wYYtCTjGTGotpgEAu9opvQ
	(envelope-from <netdev+bounces-305373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ABA719BB8
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:26:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IUk7Hcbb;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305373-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305373-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01DE2306BBCE
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E07351C17;
	Tue,  7 Jul 2026 09:19:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBF33066D
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:19:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415986; cv=none; b=WoNQUv6usLpn74Su4uouwwd6r4V8WtdZusJV30y+51RN6HdSM+AvDzxmrfI1ILA9ZGiyHLYkireEGINkVHy216/pimgK5Nbwxke/FG8ED2PHAZ9CzxroaL6HVlOduAfktXm3C5GaR3cuwp9Ue32yYLfPnR8fK+9jJ7zFEZkDPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415986; c=relaxed/simple;
	bh=NU0rBDuW3hqqQ335gS8fr6UEd2eaRJYk/8Vsf7gtHyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvKDEQXxsPsCW3ek9CUDx8MmDXgvGpojZpLH4r5shFGR6Rp6vLQ/O/A6bUrOqmiI0LEhAeIll4H3XQh+GDk7UQp4WLhm/XPGrv9uUuixRyOKjrXy8rMmZ3YR04J/uYUZzhgUB/jHXFT9FQVMb2CT8HLpkXI+Q/eMnbnx4dBYMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUk7Hcbb; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783415982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAElCoJw231UvshzlFX+sLDOh5XJPs/SKqbmkEExXh4=;
	b=IUk7HcbbRTgDeijFdGfhhC1S7tycVEjo1BvoH6zKzctFd/QtWJXLgD3fDWYlKRHPCZ83eM
	Q+mADRzDpauppfF/SlDR7ogue4XTpBU2K2BIacLuSqaLcgGk0I5J8bG2baKuwcqQzdD6k4
	ZsixlwUqJucj3BdTpXZX8VFG9HrA/9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-s6Ho7sVpP--j52i8LTSMTA-1; Tue,
 07 Jul 2026 05:19:38 -0400
X-MC-Unique: s6Ho7sVpP--j52i8LTSMTA-1
X-Mimecast-MFC-AGG-ID: s6Ho7sVpP--j52i8LTSMTA_1783415977
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA0C41808954;
	Tue,  7 Jul 2026 09:19:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 642C53000C00;
	Tue,  7 Jul 2026 09:19:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: maimon.sagi@gmail.com
Cc: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3] ptp: ocp: add CPLD ISP support for ADVA TimeCard
Date: Tue,  7 Jul 2026 11:19:26 +0200
Message-ID: <20260707091926.88033-1-pabeni@redhat.com>
In-Reply-To: <20260701072203.4321-1-maimon.sagi@gmail.com>
References: <20260701072203.4321-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maimon.sagi@gmail.com,m:jonathan.lemon@gmail.com,m:vadim.fedorenko@linux.dev,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:maimonsagi@gmail.com,m:jonathanlemon@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57ABA719BB8

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ptp: ocp: add CPLD ISP support for ADVA TimeCard

This change adds a sysfs interface on the adva_x1 ptp_ocp variant to
own a secondary I2C bus and forward arbitrary I2C transactions to a
Lattice MachXO3 CPLD for in-system programming. A new attribute
i2c_bus_ctrl controls bus ownership, and a bin_attr cpld_i2c_xfer
implements a write-request/read-response RPC guarded by an
allowlisted address set.

A few questions on the implementation below.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78..86c341ea4062 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -416,6 +416,10 @@ struct ptp_ocp {
>  	dpll_tracker tracker;
>  	int signals_nr;
>  	int freq_in_nr;
> +	/* cpld_i2c_xfer sysfs (adva_x1) */
> +	struct mutex		tap_i2c_lock;
> +	u8			tap_i2c_rsp[21]; /* [status, read_data...] */
> +	size_t			tap_i2c_rsp_len;
>  };

[Low]
Should tap_i2c_lock be paired with mutex_destroy() on the
ptp_ocp_detach()/ptp_ocp_dev_release() paths? The mutex is initialized
here but never destroyed, which skips the lockdep/DEBUG_MUTEXES
validation that the lock is not held at teardown and breaks the usual
init/destroy symmetry for driver-owned mutexes.

> @@ -3188,6 +3192,8 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>  	ptp_ocp_nmea_out_init(bp);
>  	ptp_ocp_signal_init(bp);
>  
> +	mutex_init(&bp->tap_i2c_lock);
> +
>  	err = ptp_ocp_attr_group_add(bp, info->attr_groups);
>  	if (err)
>  		return err;

[Low]
The commit message says the interface is available on "ADVA TimeCard
boards", but only adva_timecard_x1_group gets the new attributes;
adva_timecard_group is unchanged. However mutex_init() lives in
ptp_ocp_adva_board_init(), which is called for both the adva and
adva_x1 variants, so the mutex is initialized on non-x1 hardware where
tap_i2c_rsp is never consumed. Should the commit message clarify that
this is x1-specific, or should the feature be exposed on the base
adva variant as well?

> @@ -4224,6 +4230,171 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>  
> +static ssize_t
> +i2c_bus_ctrl_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +
> +	if (!bp->pps_select)
> +		return -ENODEV;
> +	return sysfs_emit(buf, "0x%08x\n",
> +			  ioread32(&bp->pps_select->__pad1));
> +}
> +
> +static ssize_t
> +i2c_bus_ctrl_store(struct device *dev, struct device_attribute *attr,
> +		   const char *buf, size_t count)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!bp->pps_select)
> +		return -ENODEV;
> +	if (kstrtou32(buf, 0, &val))
> +		return -EINVAL;
> +	iowrite32(val, &bp->pps_select->__pad1);
> +	return count;
> +}

[Medium]
Is it safe to repurpose struct gpio_reg's __pad1 field as a live control
register? The struct declares that slot as u32 __pad1, a padding/reserved
member, and pps_select is registered for every board variant via
OCP_MEM_RESOURCE(pps_select). Could a future rearrangement of gpio_reg
padding silently break this, and does offset 0xC of pps_select do
something different (or truly reserved) on non-adva-x1 boards where an
accidental write could produce undefined FPGA behavior? Would renaming
the field (for example to i2c_bus_ctrl) and documenting its per-variant
meaning make the intent clearer?

[Low]
Since this write hands ownership of a shared I2C bus between the host
and the on-board MicroBlaze, does anything guarantee the write has
been posted to the FPGA before userspace triggers the next
cpld_i2c_xfer transaction? There is no read-back, barrier, or
completion polling here, so on architectures with posted PCIe writes
the first ISP transaction after a hand-off could see the old owner
and NACK or produce corrupted data.

> +static DEVICE_ATTR_RW(i2c_bus_ctrl);
> +
> +/*
> + * cpld_i2c_xfer - sysfs binary I2C passthrough for adva_x1 TAP CPLD.
> + *
> + * write: [addr][write_len][read_len][flags][write_data...]
> + *   flags bit 0: I2C_M_NOSTART on the read segment
> + * read:  [status][read_data...]
> + *   status 0 = success, else positive errno
> + *
> + * Only addresses 0x40 (CPLD) and 0x74 (mux) are permitted.
> + */

[Medium]
Both i2c_bus_ctrl and cpld_i2c_xfer become permanent userspace ABI
including a binary encoded request/response protocol (4-byte header,
status byte, allowlist, NOSTART flag bit), but no
Documentation/ABI/testing/sysfs-driver-ptp-ocp entries are added.
Would documenting the byte layout there rather than only in an inline
C source comment help lock it down as UAPI?

[Low]
As a broader design question rather than a bug: since /dev/i2c-N
(i2c-dev) already exposes arbitrary I2C transactions with the
I2C_RDWR ioctl, is a stateful sysfs bin_attr the right vehicle for
this? Related observations for maintainer consideration:

 - i2c_bus_ctrl exposes a raw MMIO register with no semantic model
   (any u32 accepted, unspecified bit meanings).

 - The CPLD/mux allowlist is hard-coded in ptp_ocp.c rather than
   instantiated as proper i2c_client/i2c_mux child devices whose
   lifetime is managed by the I2C core.

 - The driver does not hold a persistent handle to the adapter and
   rediscovers it on every write via device_for_each_child(), which
   is fragile if bind order changes or the parent hosts multiple
   adapter children.

Once this lands as UAPI it is hard to undo, so it seems worth an
explicit look.

> +#define TAP_I2C_ALLOWED_ADDRS_NUM  2
> +static const u8 tap_i2c_allowed_addrs[TAP_I2C_ALLOWED_ADDRS_NUM] = {
> +	0x40, /* CPLD */
> +	0x74, /* mux  */
> +};
> +
> +#define TAP_I2C_REQ_HDR_LEN   4
> +#define TAP_I2C_MAX_WRITE_LEN 67
> +#define TAP_I2C_MAX_READ_LEN  20
> +#define TAP_I2C_FLAG_NOSTART  BIT(0)
> +
> +static int
> +ptp_ocp_tap_i2c_find_adapter(struct device *dev, void *data)
> +{
> +	struct i2c_adapter **adap = data;
> +
> +	*adap = i2c_verify_adapter(dev);
> +	return (*adap) ? 1 : 0;
> +}
> +
> +static ssize_t
> +ptp_ocp_cpld_i2c_write(struct file *file, struct kobject *kobj,
> +		       const struct bin_attribute *attr,
> +		       char *buf, loff_t off, size_t count)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> +	const u8 *req = (const u8 *)buf;
> +	u8 addr, write_len, read_len, flags;
> +	struct i2c_adapter *adap = NULL;
> +	struct i2c_msg msgs[2];
> +	u8 rdbuf[TAP_I2C_MAX_READ_LEN];
> +	int nmsgs, ret, i;
> +
> +	if (count < TAP_I2C_REQ_HDR_LEN || count > TAP_I2C_REQ_HDR_LEN + TAP_I2C_MAX_WRITE_LEN)
> +		return -EINVAL;

[Medium]
Is off ignored on purpose here? If sysfs delivers a large write split
into multiple chunks, or if userspace uses pwrite() at a non-zero
offset, this handler will interpret the fragment starting at off as a
fresh [addr][write_len][read_len][flags] request and generate
arbitrary I2C traffic. The read side already rejects off > 0, so the
two ends are inconsistent.

> +	addr      = req[0];
> +	write_len = req[1];
> +	read_len  = req[2];
> +	flags     = req[3];
> +
> +	/* Validate */
> +	for (i = 0; i < TAP_I2C_ALLOWED_ADDRS_NUM; i++)
> +		if (addr == tap_i2c_allowed_addrs[i])
> +			break;
> +	if (i == TAP_I2C_ALLOWED_ADDRS_NUM)
> +		return -EPERM;
> +
> +	if (write_len > TAP_I2C_MAX_WRITE_LEN)
> +		return -EINVAL;
> +	if (read_len > TAP_I2C_MAX_READ_LEN)
> +		return -EINVAL;
> +	if (write_len + TAP_I2C_REQ_HDR_LEN > count)
> +		return -EINVAL;
> +	if (write_len == 0 && read_len == 0)
> +		return -EINVAL;
> +
> +	if (!bp->i2c_ctrl)
> +		return -ENODEV;
> +	device_for_each_child(&bp->i2c_ctrl->dev, &adap,
> +			      ptp_ocp_tap_i2c_find_adapter);
> +	if (!adap)
> +		return -ENODEV;

[High]
Can the adapter go away between this lookup and i2c_transfer()?
device_for_each_child() only holds a klist iterator reference for the
duration of the callback and drops it via klist_iter_exit() before
returning, and i2c_verify_adapter() is just a type check that takes no
reference:

    static int
    ptp_ocp_tap_i2c_find_adapter(struct device *dev, void *data)
    {
        struct i2c_adapter **adap = data;

        *adap = i2c_verify_adapter(dev);
        return (*adap) ? 1 : 0;
    }

bp->i2c_ctrl is a platform_device, and the actual I2C adapter is a
child bound by a separate I2C controller driver that can be unbound
via /sys/bus/platform/drivers/<name>/unbind. If that happens between
device_for_each_child() returning and i2c_transfer(adap, ...), the
struct i2c_adapter may already be freed. Would taking an explicit
reference via i2c_get_adapter()/i2c_put_adapter() around the transfer
close this window?

> +
> +	nmsgs = 0;
> +	if (write_len > 0) {
> +		msgs[nmsgs].addr  = addr;
> +		msgs[nmsgs].flags = 0;
> +		msgs[nmsgs].len   = write_len;
> +		msgs[nmsgs].buf   = (u8 *)req + TAP_I2C_REQ_HDR_LEN;
> +		nmsgs++;
> +	}
> +	if (read_len > 0) {
> +		u16 rd_flags = I2C_M_RD;
> +
> +		if (flags & TAP_I2C_FLAG_NOSTART)
> +			rd_flags |= I2C_M_NOSTART;
> +		msgs[nmsgs].addr  = addr;
> +		msgs[nmsgs].flags = rd_flags;
> +		msgs[nmsgs].len   = read_len;
> +		msgs[nmsgs].buf   = rdbuf;
> +		nmsgs++;
> +	}

[Medium]
When userspace supplies flags = TAP_I2C_FLAG_NOSTART together with
write_len = 0 and read_len > 0, I2C_M_NOSTART ends up on the first (and
only) message. Documentation/i2c/i2c-protocol.rst says:

    If you set the I2C_M_NOSTART variable for the first partial
    message, we do not generate Addr, but we do generate the start
    condition S. This will probably confuse all other clients on your
    bus, so don't try this.

The CPLD sits on a mux-shared secondary bus (0x74), so should this
combination be rejected outright rather than passed through?

[Medium]
rdbuf lives on the kernel stack and is handed directly to
i2c_transfer(). Documentation/i2c/dma-considerations.rst requires
i2c_msg.buf to be DMA-safe when the underlying adapter uses DMA, and
the DMA characteristics of the adapter behind bp->i2c_ctrl are not
known to this code. Would i2c_get_dma_safe_msg_buf() /
i2c_put_dma_safe_msg_buf() be more appropriate here?

> +
> +	ret = i2c_transfer(adap, msgs, nmsgs);
> +
> +	mutex_lock(&bp->tap_i2c_lock);
> +	if (ret == nmsgs) {
> +		bp->tap_i2c_rsp[0] = 0;
> +		if (read_len > 0)
> +			memcpy(&bp->tap_i2c_rsp[1], rdbuf, read_len);
> +		bp->tap_i2c_rsp_len = 1 + read_len;
> +		ret = count;
> +	} else {
> +		bp->tap_i2c_rsp[0]  = (u8)(ret < 0 ? -ret : EIO);
> +		bp->tap_i2c_rsp_len = 1;
> +		ret = (ret < 0) ? ret : -EIO;
> +	}
> +	mutex_unlock(&bp->tap_i2c_lock);
> +
> +	return ret;
> +}

[High]
Can two concurrent users of cpld_i2c_xfer observe each other's
responses via bp->tap_i2c_rsp?

The mutex is only held while publishing the result and is released
before the corresponding read() runs. Consider:

    Writer A: i2c_transfer() completes with data X, preempted before
              taking tap_i2c_lock
    Writer B: i2c_transfer() completes with data Y, publishes Y under
              the lock, releases lock
    Writer A: resumes, publishes X under the lock
    Reader B: reads and gets Writer A's X

Even a single well-behaved userspace process performs write() and
read() as separate syscalls with no session identity, so nothing ties
a read() back to the write() that produced it. For a stateful ISP
session with the CPLD, is there a mechanism (open-exclusive, per-fd
buffer, single write/read syscall pair, ioctl-style) that would keep
transactions correlated?

[Medium]
Is the "positive errno" contract in the header comment held by this
encoding?

    bp->tap_i2c_rsp[0]  = (u8)(ret < 0 ? -ret : EIO);

Any errno whose low 8 bits are zero (for example -ENOTSUPP is 524 and
truncates to 12, which happens to be ENOMEM; values like 256 or 512
would truncate to 0 and encode "success") ends up in the shadow buffer
as a completely different or false-success value. For userspace ISP
tools that consult this status byte to decide whether to continue
programming, would returning the errno as a wider field (or capping
the values that can appear) be safer?

> +
> +static ssize_t
> +ptp_ocp_cpld_i2c_read(struct file *file, struct kobject *kobj,
> +		      const struct bin_attribute *attr,
> +		      char *buf, loff_t off, size_t count)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(kobj_to_dev(kobj));
> +	ssize_t ret;
> +
> +	if (off > 0)
> +		return 0;
> +
> +	mutex_lock(&bp->tap_i2c_lock);
> +	ret = min(count, bp->tap_i2c_rsp_len);
> +	memcpy(buf, bp->tap_i2c_rsp, ret);
> +	mutex_unlock(&bp->tap_i2c_lock);
> +	return ret;
> +}

[Medium]
Does this drop response bytes on short reads? off is not honored: if
userspace reads with count < tap_i2c_rsp_len (up to 21 bytes), the
first read returns the leading fragment and advances the file
position, then the next read arrives with off > 0 and this handler
returns 0 (EOF), so the tail of the response is lost. Would the usual
bin_attribute pattern

    memcpy(buf, bp->tap_i2c_rsp + off,
           min(count, bp->tap_i2c_rsp_len - off));

be more appropriate here?

> +
> +static const struct bin_attribute tap_i2c_bin_attr = {
> +	.attr  = { .name = "cpld_i2c_xfer", .mode = 0600 },
> +	.write = ptp_ocp_cpld_i2c_write,
> +	.read  = ptp_ocp_cpld_i2c_read,
> +};
> +

[ ... ]
-- 
This is an AI-generated review.


