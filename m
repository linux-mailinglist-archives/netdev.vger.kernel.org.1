Return-Path: <netdev+bounces-242553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F8C920EB
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B4B3A5D36
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368472FD699;
	Fri, 28 Nov 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m3P7lKb7"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AA19AD90;
	Fri, 28 Nov 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334845; cv=none; b=rJNVir8MSKzy/ZY6Qotf9qV8oa8QDJ8ZXRK7G1jYg48qk17sSiZj9AiSoxDZu+iw/8JzV5M1KmjK+aDEzdM3Og8Mo8SMnBz3xqvjfchOpSB/ld7Mb3I57ICxHIygqHKbS/0Gf0t1+T+UEPDO4m8K6PtBeBeMVr4YEQD+CsGlnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334845; c=relaxed/simple;
	bh=N+FoN1xdF1zkg49nYQZJUBG0IxW/s3cAzVTz1awWzMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RrOrLDHL6LAIkNK2ohTV/Epb8gDTpU1zi99aX9aksddIfOZV+wGxL0edAOnzeH0vfStt1AUU6FINrUKKzNHxDWT5R47DQhHUq7xuxg2By4Omg1eQHxg7OR+ag2dOwjYqJ50NWSGBBvuBOyFLbwxHwixLe/125aFYxiHnJRLLkmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m3P7lKb7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kL+ol8JrNo6WwzplCIN7z+k9ZfC0OPGULbYQqMaNzdI=; b=m3P7lKb7ZnaqncL3fxBP+AE7NL
	0aZNhOn/cQMttg0HCLSer5sEDLI5+Q9z6F5Zr6Ca8A3coowQ0zteL80oxsa/gThvCJkG1KHkgyQy8
	3tyAJblPUSTXpKFYAIwUFaAG+QgqCJHXBpKY5gu/nUXZRMaTnlz5mkuGO6widAnwVIUn0QFQTaFKP
	1F6LDQLHE6MmcoJy0JqNG2scQCHNsPQtE+P0+sjaZOHy4gpPGXvzW/EZzket2ge/jQUliw4D1C2cp
	Gjj6Pe5E021CFK2VXTVrq2rooNFosJbOxNANokrokpcbn9DQBLn9ktoLJKfEJ3FKN/7GQwQiGtCva
	+6lM4uVw==;
Received: from [172.31.31.148] (helo=u09cd745991455d.lumleys.internal)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOxDu-0000000BvfI-44wk;
	Fri, 28 Nov 2025 12:05:15 +0000
Message-ID: <e1d7c2208ea0ec2aa6836bf4db5bf0c2bd9e4b86.camel@infradead.org>
Subject: Re: [PATCH 2/2] ptp: vmclock: support device notifications
From: David Woodhouse <dwmw2@infradead.org>
To: "Chalios, Babis" <bchalios@amazon.es>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>,  "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,  "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>, "mzxreary@0pointer.de"
	 <mzxreary@0pointer.de>
Date: Fri, 28 Nov 2025 13:00:36 +0000
In-Reply-To: <20251127103159.19816-3-bchalios@amazon.es>
References: <20251127103159.19816-1-bchalios@amazon.es>
	 <20251127103159.19816-3-bchalios@amazon.es>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-XR97w2tl/RYS2W1LkAle"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


--=-XR97w2tl/RYS2W1LkAle
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-27 at 10:32 +0000, Chalios, Babis wrote:
> Add optional support for device notifications in VMClock. When
> supported, the hypervisor will send a device notification every time it
> updates the seq_count to a new even value.
>=20
> Moreover, add support for poll() in VMClock as a means to propagate this
> notification to user space. poll() will return a POLLIN event to
> listeners every time seq_count changes to a value different than the one
> last seen (since open() or last read()/pread()). This means that when
> poll() returns a POLLIN event, listeners need to use read() to observe
> what has changed and update the reader's view of seq_count. In other
> words, after a poll() returned, all subsequent calls to poll() will
> immediately return with a POLLIN event until the listener calls read().
>=20
> The device advertises support for the notification mechanism by setting
> flag VMCLOCK_FLAG_NOTIFICATION_PRESENT in vmclock_abi flags field. If
> the flag is not present the driver won't setup the ACPI notification
> handler and poll() will always immediately return POLLHUP.
>=20
> Signed-off-by: Babis Chalios <bchalios@amazon.es>

Generally looks sane to me, thanks.

I haven't given much brain power to whether POLLHUP is the right thing
to return when poll() is invalid; I guess you have.

I also haven't looked hard into the locking on fst->seq which is
accessed during poll() and read(). Have you?

Your vmclock_setup_notification() function can return error, but you
ignore that. Which *might* have been intentional, to allow the device
to be used even without notifications if something goes wrong... but
then the condition for poll() returning POLLHUP is wrong, because that
only checks the flag that the hypervisor set, and not whether
notifications are *actually* working.

In open() you simply read seq_count from the vmclock structure but it
might be odd at that point. Do we want to wait for it to be even, like
read() does? Or just initialise fst->seq to zero?

And is there really no devm-like helper which will free your
fp->private_data for you on release()? That seems surprising.

> ---
> =C2=A0drivers/ptp/ptp_vmclock.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 113 +++++++++++++++++++++++++++++--
> =C2=A0include/uapi/linux/vmclock-abi.h |=C2=A0=C2=A0 5 ++
> =C2=A02 files changed, 113 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
> index b3a83b03d9c1..fa515375d54f 100644
> --- a/drivers/ptp/ptp_vmclock.c
> +++ b/drivers/ptp/ptp_vmclock.c
> @@ -5,6 +5,9 @@
> =C2=A0 * Copyright =C2=A9 2024 Amazon.com, Inc. or its affiliates.
> =C2=A0 */
> =C2=A0
> +#include "linux/poll.h"
> +#include "linux/types.h"
> +#include "linux/wait.h"
> =C2=A0#include <linux/acpi.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/err.h>
> @@ -39,6 +42,7 @@ struct vmclock_state {
> =C2=A0	struct resource res;
> =C2=A0	struct vmclock_abi *clk;
> =C2=A0	struct miscdevice miscdev;
> +	wait_queue_head_t disrupt_wait;
> =C2=A0	struct ptp_clock_info ptp_clock_info;
> =C2=A0	struct ptp_clock *ptp_clock;
> =C2=A0	enum clocksource_ids cs_id, sys_cs_id;
> @@ -357,10 +361,15 @@ static struct ptp_clock *vmclock_ptp_register(struc=
t device *dev,
> =C2=A0	return ptp_clock_register(&st->ptp_clock_info, dev);
> =C2=A0}
> =C2=A0
> +struct vmclock_file_state {
> +	struct vmclock_state *st;
> +	uint32_t seq;
> +};
> +
> =C2=A0static int vmclock_miscdev_mmap(struct file *fp, struct vm_area_str=
uct *vma)
> =C2=A0{
> -	struct vmclock_state *st =3D container_of(fp->private_data,
> -						struct vmclock_state, miscdev);
> +	struct vmclock_file_state *fst =3D fp->private_data;
> +	struct vmclock_state *st =3D fst->st;
> =C2=A0
> =C2=A0	if ((vma->vm_flags & (VM_READ|VM_WRITE)) !=3D VM_READ)
> =C2=A0		return -EROFS;
> @@ -379,8 +388,9 @@ static int vmclock_miscdev_mmap(struct file *fp, stru=
ct vm_area_struct *vma)
> =C2=A0static ssize_t vmclock_miscdev_read(struct file *fp, char __user *b=
uf,
> =C2=A0				=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> =C2=A0{
> -	struct vmclock_state *st =3D container_of(fp->private_data,
> -						struct vmclock_state, miscdev);
> +	struct vmclock_file_state *fst =3D fp->private_data;
> +	struct vmclock_state *st =3D fst->st;
> +
> =C2=A0	ktime_t deadline =3D ktime_add(ktime_get(), VMCLOCK_MAX_WAIT);
> =C2=A0	size_t max_count;
> =C2=A0	uint32_t seq;
> @@ -402,8 +412,10 @@ static ssize_t vmclock_miscdev_read(struct file *fp,=
 char __user *buf,
> =C2=A0
> =C2=A0		/* Pairs with hypervisor wmb */
> =C2=A0		virt_rmb();
> -		if (seq =3D=3D le32_to_cpu(st->clk->seq_count))
> +		if (seq =3D=3D le32_to_cpu(st->clk->seq_count)) {
> +			fst->seq =3D seq;
> =C2=A0			break;
> +		}
> =C2=A0
> =C2=A0		if (ktime_after(ktime_get(), deadline))
> =C2=A0			return -ETIMEDOUT;
> @@ -413,10 +425,58 @@ static ssize_t vmclock_miscdev_read(struct file *fp=
, char __user *buf,
> =C2=A0	return count;
> =C2=A0}
> =C2=A0
> +static __poll_t vmclock_miscdev_poll(struct file *fp, poll_table *wait)
> +{
> +	struct vmclock_file_state *fst =3D fp->private_data;
> +	struct vmclock_state *st =3D fst->st;
> +	uint32_t seq;
> +
> +	/*
> +	 * Hypervisor will not send us any notifications, so fail immediately
> +	 * to avoid having caller sleeping for ever.
> +	 */
> +	if (!(st->clk->flags & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
> +		return POLLHUP;
> +
> +	poll_wait(fp, &st->disrupt_wait, wait);
> +
> +	seq =3D le32_to_cpu(st->clk->seq_count);
> +	if (fst->seq !=3D seq)
> +		return POLLIN | POLLRDNORM;
> +
> +	return 0;
> +}
> +
> +static int vmclock_miscdev_open(struct inode *inode, struct file *fp)
> +{
> +	struct vmclock_state *st =3D container_of(fp->private_data,
> +						struct vmclock_state, miscdev);
> +	struct vmclock_file_state *fst =3D kzalloc(sizeof(*fst), GFP_KERNEL);
> +
> +	if (!fst)
> +		return -ENOMEM;
> +
> +	fst->st =3D st;
> +	fst->seq =3D le32_to_cpu(st->clk->seq_count);
> +
> +	fp->private_data =3D fst;
> +
> +	return 0;
> +}
> +
> +static int vmclock_miscdev_release(struct inode *inode, struct file *fp)
> +{
> +	kfree(fp->private_data);
> +	return 0;
> +}
> +
> =C2=A0static const struct file_operations vmclock_miscdev_fops =3D {
> =C2=A0	.owner =3D THIS_MODULE,
> +	.open =3D vmclock_miscdev_open,
> +	.release =3D vmclock_miscdev_release,
> =C2=A0	.mmap =3D vmclock_miscdev_mmap,
> =C2=A0	.read =3D vmclock_miscdev_read,
> +	.poll =3D vmclock_miscdev_poll,
> =C2=A0};
> =C2=A0
> =C2=A0/* module operations */
> @@ -459,6 +519,44 @@ static acpi_status vmclock_acpi_resources(struct acp=
i_resource *ares, void *data
> =C2=A0	return AE_ERROR;
> =C2=A0}
> =C2=A0
> +static void
> +vmclock_acpi_notification_handler(acpi_handle __always_unused handle,
> +				=C2=A0 u32 __always_unused event, void *dev)
> +{
> +	struct device *device =3D dev;
> +	struct vmclock_state *st =3D device->driver_data;
> +
> +	wake_up_interruptible(&st->disrupt_wait);
> +}
> +
> +static int vmclock_setup_notification(struct device *dev, struct vmclock=
_state *st)
> +{
> +	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> +	acpi_status status;
> +
> +	/*
> +	 * This should never happen as this function is only called when
> +	 * has_acpi_companion(dev) is true, but the logic is sufficiently
> +	 * complex that Coverity can't see the tautology.
> +	 */
> +	if (!adev)
> +		return -ENODEV;
> +
> +	/* The device does not support notifications. Nothing else to do */
> +	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))
> +		return 0;
> +
> +	status =3D acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY=
,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 vmclock_acpi_notification_handler,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 dev);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "failed to install notification handler");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0static int vmclock_probe_acpi(struct device *dev, struct vmclock_st=
ate *st)
> =C2=A0{
> =C2=A0	struct acpi_device *adev =3D ACPI_COMPANION(dev);
> @@ -549,6 +647,9 @@ static int vmclock_probe(struct platform_device *pdev=
)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	init_waitqueue_head(&st->disrupt_wait);
> +	vmclock_setup_notification(dev, st);
> +
> =C2=A0	/*
> =C2=A0	 * If the structure is big enough, it can be mapped to userspace.
> =C2=A0	 * Theoretically a guest OS even using larger pages could still
> @@ -581,6 +682,8 @@ static int vmclock_probe(struct platform_device *pdev=
)
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> +	dev->driver_data =3D st;
> +
> =C2=A0	dev_info(dev, "%s: registered %s%s%s\n", st->name,
> =C2=A0		 st->miscdev.minor ? "miscdev" : "",
> =C2=A0		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
> diff --git a/include/uapi/linux/vmclock-abi.h b/include/uapi/linux/vmcloc=
k-abi.h
> index 937fe00e4f33..d320623b0118 100644
> --- a/include/uapi/linux/vmclock-abi.h
> +++ b/include/uapi/linux/vmclock-abi.h
> @@ -121,6 +121,11 @@ struct vmclock_abi {
> =C2=A0	 * loaded from some save state (restored from a snapshot).
> =C2=A0	 */
> =C2=A0#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT=C2=A0=C2=A0=C2=A0=C2=A0=
 (1 << 8)
> +	/*
> +	 * If the NOTIFICATION_PRESENT flag is set, the hypervisor will send
> +	 * a notification every time it updates seq_count to a new even number.
> +	 */
> +#define VMCLOCK_FLAG_NOTIFICATION_PRESENT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (1 << 9)
> =C2=A0
> =C2=A0	__u8 pad[2];
> =C2=A0	__u8 clock_status;


--=-XR97w2tl/RYS2W1LkAle
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MTEyODEzMDAz
NlowLwYJKoZIhvcNAQkEMSIEIAku+0bKPoyS1fWVnxttvkmnKOE1gAGjglp5KZvX5zI+MGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIAgx80z+1+8uFW
Y+K2ZduGj+1Lwvnv7175qjC8riWzswEQDx+9ge4oHK/CULh+bvDaCCxFQffChdOCUGdquE7MvCSO
DUsO1z0tvr3oKeopvGZCjTS/xNIpVDZfddxSnr47c1c+g1LNPJjQS8HbdzN3x8Zo4OtEhuANp9F9
Zp4T/NNu5xYCbzLw40zv/Nc7cQnn3e8XciQ1O13L4pZ9PxuRc9F2m48H5H6sp/mdAHK4w95i03g9
wFk6OknqpEFLaouTu9Z/b2Rdeo8rXVXm8/pi3ShLbG3exA00CEcGw4fmUI+RZebCaHkY1SFXr6cY
IxIrzZ8ONbjnx24HgTVyuE0ysIJWm48sktnBrZ9GNrLhVMYCq21h8hlGvU9GsKvu6rqj/714SiZW
t/eSxxzJfOkexJHCtcypwPgmhbOdt7skYyyXrzQMv4gtbFjyJgqwK/Dm0Gw9RW+zHseU3ma7fNiR
F8N/8sBxh2n066wAS8CUdV+JFyo1hPBI/7mxvDkOChGzBar/ytVUdzosQDsRoyy6orvz9BlMR3Xq
B/Et71E+r4f1FsOZPUmCH6+CGoqZJnWMoPvk365/H9aRk5IdcJHqSDoYuGkzBmvaExVlTavsfkUe
OwJbcnBnQ5xxXNMwtE+VxOmY0v7HOBTYZOU1SQvoahLv1vj+dpbTiI895kmk3QoAAAAAAAA=


--=-XR97w2tl/RYS2W1LkAle--

