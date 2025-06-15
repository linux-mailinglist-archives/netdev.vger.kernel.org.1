Return-Path: <netdev+bounces-197885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50BCADA258
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91C53B0A3F
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08821448D5;
	Sun, 15 Jun 2025 15:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjgdM7MV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851E1E89C
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001714; cv=none; b=H549nfypakxdTzpR0GIhAaOyO+MrH0ih2Y3hoXiyg0QKBH/phu20ORmSqkKMOPuAOZwAcj63QVC7aB+h6vHW9VA0o5AHHtRibXPvfKo3VidAnrMDgtXHF+ZhjHMcESuyNGQ7v/94onVv3GHTGVYPYIaAzYjQ/Z3trXE7O7mkGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001714; c=relaxed/simple;
	bh=60VIZdmWMGbBZu9/wWgCZjuRKLzWC7kYmfzvz3zPGsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSWNCwY2xG6qMmNlB1P3AxQhAHEdGdMv+7YBxvogbNS9LNLTCVMU/xzM9gNiRAfIGXT0XmrsThLD3/irTMMoAy/4ybRsohKXeaLm+hspZbWZlFP8GHdyjDYD+FUVgZ2lcEOqqLx0V2tqf+9HFX0Jx3bn7/fsw4qcDijiqMrJqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjgdM7MV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313154270bbso4042455a91.2
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750001712; x=1750606512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PL6h4Ao0Egb3Sd1+0ixyAMgWP2wygfHs5bQbM6+WaV0=;
        b=mjgdM7MVS4x7JcSAxNVVvcc+ph9LOYe7KD/bofFPhnnH9pSyyLbGQcrp0dmNVZ1JwW
         BzRbap7bbTvOpVX36HckboumX3gc5d27lMmE+Shwg3JqVjiCbRCXjUu/2mvP3+ArdC1i
         g2Hw826QlaeoGUHb2b45lY24aujh7Mh29sBVuBkFjLPoinHbrk6kxB6w540Dym2MkZTB
         3HLdsh7YOCLm6zRb4cjyycCfVtMUJ/JSoUkDCFAdJdjER7/QQEBbIwt+/R64MXJI4V6x
         DENBCjehSGnfljasurgMV+AObjcMLSA17lLxqXSg0vc/sQPLqjdIfjp/LmpVDEalR8vy
         UGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750001712; x=1750606512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL6h4Ao0Egb3Sd1+0ixyAMgWP2wygfHs5bQbM6+WaV0=;
        b=NiYAsFj9SH4h96aUHf4JNob/8eKTOYwkHiUrRMsRwoEQwi1IdVD7gczhrTOemAbbMJ
         CtGZoSoqbGaiTvcYOIBFijkzrjFZj9TlHz/PXEOnkTxLlVP7cQyipgYUgtiTPVe2t/VH
         bCv9AYKMWihjl2RcWfn9BxSZflSOfxteHRFcq/CZgePxH9Hxqibi8kxNrxUj77Xt8ZgO
         HsUdIGUNQeShTF9/7R7ny4inyIiAyZ9kVxpSwDpuHMSfTyHMx4Q48IiIKMSwf0cBL5hX
         VrZCS7iD1ylnl07kS+MZ1n/+diLDUqAq8jKBQw8bvEgSLGHfuOCoAnOckGPOWLiyDVbM
         5Tyw==
X-Gm-Message-State: AOJu0YxcDOMTtoNgjqsXjFX7Pz6Dh+5z9Es3OKomqQMkwcEwplHAVP+1
	RJpmXHMGmbJC+SNN6QSuFyAwa5C4QnT8RmwOwAuBCtRLILijb4aavE1PQ+QStdfCPA8fYFHAo6B
	RKQBsxGMXHgD0d5KJNhUbJ02DJh4OOWw=
X-Gm-Gg: ASbGncv2jrm5gGE3r6udkkVUpI4CXJPJNYTQIgPuZv/rX1Q4Jm4tIkkWaoMp80KM+84
	cqH05i3NNbMfNBjnwFaOBey1HRlvNjPkY/DoZhzL1Eu3ALJI5n/JXjS25oX7EKoYXBVAOUlh5wb
	VxJE97NLkH37RRLZ5pN3qHGB4TigC+HKu00vzJotns9pQbdA==
X-Google-Smtp-Source: AGHT+IH8G/qo2f+SIfJQEwtDvY2bJgkHESriRc0KgexdcGLbGm74wDD0iB2HZgltoG/mPrfyPNJ8+XDwX8QS6260haQ=
X-Received: by 2002:a17:90b:48cc:b0:311:a4d6:30f8 with SMTP id
 98e67ed59e1d1-313f1c098b9mr9191679a91.13.1750001712112; Sun, 15 Jun 2025
 08:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613174749.406826-1-vladimir.oltean@nxp.com> <20250613174749.406826-2-vladimir.oltean@nxp.com>
In-Reply-To: <20250613174749.406826-2-vladimir.oltean@nxp.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 16 Jun 2025 00:34:59 +0900
X-Gm-Features: AX0GCFvHv_huLNviUfsx3qhPGqpfH-b3fR4kg7lXccvx5ndQuCbnoUIorOrllQ0
Message-ID: <CAO9qdTE0jt5U_dN09kPEzu-NUCds2VY1Ch2up9RoLazsc1j49w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ptp: fix breakage after ptp_vclock_in_use() rework
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"

Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> What is broken
> --------------
>
> ptp4l, and any other application which calls clock_adjtime() on a
> physical clock, is greeted with error -EBUSY after commit 87f7ce260a3c
> ("ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()").
>
> Explanation for the breakage
> ----------------------------
>
> The blamed commit was based on the false assumption that
> ptp_vclock_in_use() callers already test for n_vclocks prior to calling
> this function.
>
> This is notably incorrect for the code path below, in which there is, in
> fact, no n_vclocks test:
>
> ptp_clock_adjtime()
> -> ptp_clock_freerun()
>    -> ptp_vclock_in_use()
>
> The result is that any clock adjustment on any physical clock is now
> impossible. This is _despite_ there not being any vclock over this
> physical clock.
>
> $ ptp4l -i eno0 -2 -P -m
> ptp4l[58.425]: selected /dev/ptp0 as PTP clock
> [   58.429749] ptp: physical clock is free running
> ptp4l[58.431]: Failed to open /dev/ptp0: Device or resource busy
> failed to create a clock
> $ cat /sys/class/ptp/ptp0/n_vclocks
> 0
>
> The patch makes the ptp_vclock_in_use() function say "if it's not a
> virtual clock, then this physical clock does have virtual clocks on
> top".
>
> Then ptp_clock_freerun() uses this information to say "this physical
> clock has virtual clocks on top, so it must stay free-running".
>
> Then ptp_clock_adjtime() uses this information to say "well, if this
> physical clock has to be free-running, I can't do it, return -EBUSY".
>
> Simply put, ptp_vclock_in_use() cannot be simplified so as to remove the
> test whether vclocks are in use.
>
> What did the blamed commit intend to fix
> ----------------------------------------
>
> The blamed commit presents a lockdep warning stating "possible recursive
> locking detected", with the n_vclocks_store() and ptp_clock_unregister()
> functions involved.
>
> The recursive locking seems this:
> n_vclocks_store()
> -> mutex_lock_interruptible(&ptp->n_vclocks_mux) // 1
> -> device_for_each_child_reverse(..., unregister_vclock)
>    -> unregister_vclock()
>       -> ptp_vclock_unregister()
>          -> ptp_clock_unregister()
>             -> ptp_vclock_in_use()
>                -> mutex_lock_interruptible(&ptp->n_vclocks_mux) // 2
>
> The issue can be triggered by creating and then deleting vclocks:
> $ echo 2 > /sys/class/ptp/ptp0/n_vclocks
> $ echo 0 > /sys/class/ptp/ptp0/n_vclocks
>
> But note that in the original stack trace, the address of the first lock
> is different from the address of the second lock. This is because at
> step 1 marked above, &ptp->n_vclocks_mux is the lock of the parent
> (physical) PTP clock, and at step 2, the lock is of the child (virtual)
> PTP clock. They are different locks of different devices.
>
> In this situation there is no real deadlock, the lockdep warning is
> caused by the fact that the mutexes have the same lock class on both the
> parent and the child. Functionally it is fine.
>
> Proposed alternative solution
> -----------------------------
>
> We must reintroduce the body of ptp_vclock_in_use() mostly as it was
> structured prior to the blamed commit, but avoid the lockdep warning.
>
> Based on the fact that vclocks cannot be nested on top of one another
> (ptp_is_attribute_visible() hides n_vclocks for virtual clocks), we
> already know that ptp->n_vclocks is zero for a virtual clock. And
> ptp->is_virtual_clock is a runtime invariant, established at
> ptp_clock_register() time and never changed. There is no need to
> serialize on any mutex in order to read ptp->is_virtual_clock, and we
> take advantage of that by moving it outside the lock.
>
> Thus, virtual clocks do not need to acquire &ptp->n_vclocks_mux at
> all, and step 2 in the code walkthrough above can simply go away.
> We can simply return false to the question "ptp_vclock_in_use(a virtual
> clock)".
>
> Other notes
> -----------
>
> Releasing &ptp->n_vclocks_mux before ptp_vclock_in_use() returns
> execution seems racy, because the returned value can become stale as
> soon as the function returns and before the return value is used (i.e.
> n_vclocks_store() can run any time). The locking requirement should
> somehow be transferred to the caller, to ensure a longer life time for
> the returned value, but this seems out of scope for this severe bug fix.
>
> Because we are also fixing up the logic from the original commit, there
> is another Fixes: tag for that.
>

Thanks for quickly finding the part I missed!

As you said, I confirmed that adjtime and settime functions do not work
properly due to this commit.

However, I don't think it is appropriate to fix ptp_vclock_in_use().
I agree that ptp->n_vclocks should be checked in the path where
ptp_clock_freerun() is called, but there are many drivers that do not
have any contact with ptp->n_vclocks in the path where
ptp_clock_unregister() is called.

The reason I removed the ptp->n_vclocks check logic from the
ptp_vclock_in_use() function is to prevent false positives from lockdep,
but also to prevent the performance overhead caused by locking
ptp->n_vclocks_mux and checking ptp->n_vclocks when calling
ptp_vclock_in_use() from a driver that has nothing to do with
ptp->n_vclocks.

Therefore, I think it would be appropriate to modify ptp_clock_freerun()
like this instead of ptp_vclock_in_use():
---
 drivers/ptp/ptp_private.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 528d86a33f37..abd99087f0ca 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -104,10 +104,20 @@ static inline bool ptp_vclock_in_use(struct
ptp_clock *ptp)
 /* Check if ptp clock shall be free running */
 static inline bool ptp_clock_freerun(struct ptp_clock *ptp)
 {
+   bool ret = false;
+
    if (ptp->has_cycles)
-       return false;
+       return ret;
+
+   if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
+       return true;
+
+   if (ptp_vclock_in_use(ptp) && ptp->n_vclocks)
+       ret = true;
+
+   mutex_unlock(&ptp->n_vclocks_mux);

-   return ptp_vclock_in_use(ptp);
+   return ret;
 }

 extern const struct class ptp_class;
-- 

I tested this patch with test.c and confirmed that
ptp_clock_{adj,set}time() works correctly again after applying this patch.

test.c:
```c
// gcc -o test test.c -lrt

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <math.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/timex.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include <linux/ptp_clock.h>

static clockid_t get_clockid(int fd)
{
#define CLOCKFD 3
#define FD_TO_CLOCKID(fd)   ((~(clockid_t) (fd) << 3) | CLOCKFD)
    return FD_TO_CLOCKID(fd);
}

int main() {
    int fd = open("/dev/ptp0", O_RDWR);
    clockid_t clockid = get_clockid(fd);
    struct timex tx;
    struct timespec ts;

    memset(&tx, 0, sizeof(tx));
    tx.modes = ADJ_OFFSET;
    tx.time.tv_sec = 0;
    tx.time.tv_usec = 0;

    clock_adjtime(clockid, &tx);

    ts.tv_sec = 0;
    ts.tv_nsec = 0;

    clock_settime(clockid, &ts);

    return 0;
}
```

> Fixes: 87f7ce260a3c ("ptp: remove ptp->n_vclocks check logic in ptp_vclock_in_use()")
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/ptp/ptp_private.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 528d86a33f37..a6aad743c282 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -98,7 +98,27 @@ static inline int queue_cnt(const struct timestamp_event_queue *q)
>  /* Check if ptp virtual clock is in use */
>  static inline bool ptp_vclock_in_use(struct ptp_clock *ptp)
>  {
> -       return !ptp->is_virtual_clock;
> +       bool in_use = false;
> +
> +       /* Virtual clocks can't be stacked on top of virtual clocks.
> +        * Avoid acquiring the n_vclocks_mux on virtual clocks, to allow this
> +        * function to be called from code paths where the n_vclocks_mux of the
> +        * parent physical clock is already held. Functionally that's not an
> +        * issue, but lockdep would complain, because they have the same lock
> +        * class.
> +        */
> +       if (ptp->is_virtual_clock)
> +               return false;
> +
> +       if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
> +               return true;
> +
> +       if (ptp->n_vclocks)
> +               in_use = true;
> +
> +       mutex_unlock(&ptp->n_vclocks_mux);
> +
> +       return in_use;
>  }
>
>  /* Check if ptp clock shall be free running */
> --
> 2.43.0
>

Regards,

Jeongjun Park

