Return-Path: <netdev+bounces-37142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C797B3D21
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 02:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6BA3C282365
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D474C179;
	Sat, 30 Sep 2023 00:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE15160
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 00:03:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA891
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 17:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696032202; x=1727568202;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=myYYs80YsWCKNaLhYfnfB95eH0tmDIiYNuzVNBF+GQw=;
  b=RdjIVGhy4oQUNYiJSorG6KuHcKnmXmSyVbGwP5MPtx4Lw8uHrf7MwT+M
   OfQxB8dM71lvFy6oatzLRNJQP/u7A5AtIoA18uIpmGxjKno+z0hFdz0bN
   ihtoKY3DvzRHLwRD8p0NLWC+/6DzxbnZuABtQtXKOQ84WiW6/lt200rgK
   CB2vzZ4ycvx5F0PNEsTBMif/G3Mo9Pu/lYwtc4co8udT1dccNawp8hdPD
   ASDtRLjof5U0mSQMudfl1jQFsGVJrkjafQtDsfesiiHFMBi0fmb/fyRTi
   JaGI0DjdMejCotSoZe1PVX9HN7rtdy4ZOijQTbklQKy88eFDsBwO+L9RP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367461945"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="367461945"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 17:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="750074142"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="750074142"
Received: from jinsungk-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.192.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 17:03:21 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, horms@kernel.org,
 chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com, reibax@gmail.com,
 ntp-lists@mattcorallo.com, alex.maftei@amd.com, davem@davemloft.net,
 rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v3 3/3] ptp: support event queue reader channel
 masks
In-Reply-To: <20230928133544.3642650-4-reibax@gmail.com>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-4-reibax@gmail.com>
Date: Fri, 29 Sep 2023 17:03:21 -0700
Message-ID: <87jzs84jee.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xabier Marquiegui <reibax@gmail.com> writes:

> Implement ioctl to support filtering of external timestamp event queue
> channels per reader based on the process PID accessing the timestamp
> queue.
>
> Can be tested using testptp test binary. Use lsof to figure out readers
> of the DUT. LSB of the timestamp channel mask is channel 0.
>
> eg: To view all current users of the device:
> ```
>  # testptp -F  /dev/ptp0 
> (USER PID)     TSEVQ FILTER ID:MASK
> (3234)              1:0x00000001
> (3692)              2:0xFFFFFFFF
> (3792)              3:0xFFFFFFFF
> (8713)              4:0xFFFFFFFF
> ```
>
> eg: To allow ID 1 to access only ts channel 0:
> ```
>  # testptp -F 1,0x1
> ```
>
> eg: To allow ID 1 to access any channel:
> ```
>  # testptp -F 1,0xFFFFFFFF
> ```
>
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> ---
> v3:
>   - filter application by object id, aided by process id
>   - friendlier testptp implementation of event queue channel filters
> v2: https://lore.kernel.org/netdev/20230912220217.2008895-3-reibax@gmail.com/
>   - fix testptp compilation error: unknown type name 'pid_t'
>   - rename mask variable for easier code traceability
>   - more detailed commit message with two examples
> v1: https://lore.kernel.org/netdev/20230906104754.1324412-4-reibax@gmail.com/
>
>  drivers/ptp/ptp_chardev.c             |  85 +++++++++++++-
>  drivers/ptp/ptp_clock.c               |   4 +-
>  drivers/ptp/ptp_private.h             |   1 +
>  include/uapi/linux/ptp_clock.h        |  12 ++
>  tools/testing/selftests/ptp/testptp.c | 158 ++++++++++++++++++++------
>  5 files changed, 221 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index 65e7acaa40a9..14b5bd7e7ca2 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -114,6 +114,7 @@ int ptp_open(struct posix_clock_user *pcuser, fmode_t fmode)
>  	if (!queue)
>  		return -EINVAL;
>  	queue->close_req = false;
> +	queue->mask = 0xFFFFFFFF;
>  	queue->reader_pid = task_pid_nr(current);
>  	spin_lock_init(&queue->lock);
>  	queue->ida = ida;
> @@ -169,19 +170,28 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
>  {
>  	struct ptp_clock *ptp =
>  		container_of(pcuser->clk, struct ptp_clock, clock);
> +	struct ptp_tsfilter tsfilter_set, *tsfilter_get = NULL;
>  	struct ptp_sys_offset_extended *extoff = NULL;
>  	struct ptp_sys_offset_precise precise_offset;
>  	struct system_device_crosststamp xtstamp;
>  	struct ptp_clock_info *ops = ptp->info;
>  	struct ptp_sys_offset *sysoff = NULL;
> +	struct timestamp_event_queue *tsevq;
>  	struct ptp_system_timestamp sts;
>  	struct ptp_clock_request req;
>  	struct ptp_clock_caps caps;
>  	struct ptp_clock_time *pct;
> +	int lsize, enable, err = 0;
>  	unsigned int i, pin_index;
>  	struct ptp_pin_desc pd;
>  	struct timespec64 ts;
> -	int enable, err = 0;
> +
> +	tsevq = pcuser->private_clkdata;
> +
> +	if (tsevq->close_req) {
> +		err = -EPIPE;
> +		return err;
> +	}
>  
>  	switch (cmd) {
>  
> @@ -481,6 +491,79 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
>  		mutex_unlock(&ptp->pincfg_mux);
>  		break;
>  
> +	case PTP_FILTERCOUNT_REQUEST:
> +		/* Calculate amount of device users */
> +		if (tsevq) {
> +			lsize = list_count_nodes(&tsevq->qlist);
> +			if (copy_to_user((void __user *)arg, &lsize,
> +					 sizeof(lsize)))
> +				err = -EFAULT;
> +		}
> +		break;
> +	case PTP_FILTERTS_GET_REQUEST:
> +		/* Read operation */
> +		/* Read amount of entries expected */
> +		if (copy_from_user(&tsfilter_set, (void __user *)arg,
> +				   sizeof(tsfilter_set))) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		if (tsfilter_set.ndevusers <= 0) {
> +			err = -EINVAL;
> +			break;
> +		}
> +		/* Allocate the necessary memory space to dump the requested filter
> +		 * list
> +		 */
> +		tsfilter_get = kzalloc(tsfilter_set.ndevusers *
> +					       sizeof(struct ptp_tsfilter),
> +				       GFP_KERNEL);
> +		if (!tsfilter_get) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +		if (!tsevq) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		/* Set the whole region to 0 in case the current list is shorter than
> +		 * anticipated
> +		 */
> +		memset(tsfilter_get, 0,
> +		       tsfilter_set.ndevusers * sizeof(struct ptp_tsfilter));
> +		i = 0;
> +		/* Format data */
> +		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
> +			tsfilter_get[i].reader_rpid = tsevq->reader_pid;
> +			tsfilter_get[i].reader_oid = tsevq->oid;
> +			tsfilter_get[i].mask = tsevq->mask;
> +			i++;
> +			/* Current list is longer than anticipated */
> +			if (i >= tsfilter_set.ndevusers)
> +				break;
> +		}
> +		/* Dump data */
> +		if (copy_to_user((void __user *)arg, tsfilter_get,
> +				 tsfilter_set.ndevusers *
> +					 sizeof(struct ptp_tsfilter)))
> +			err = -EFAULT;
> +		break;
> +
> +	case PTP_FILTERTS_SET_REQUEST:
> +		/* Write Operation */
> +		if (copy_from_user(&tsfilter_set, (void __user *)arg,
> +				   sizeof(tsfilter_set))) {
> +			err = -EFAULT;
> +			break;
> +		}
> +		if (tsevq) {
> +			list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
> +				if (tsevq->oid == tsfilter_set.reader_oid)
> +					tsevq->mask = tsfilter_set.mask;
> +			}
> +		}
> +		break;
> +
>  	default:
>  		err = -ENOTTY;
>  		break;
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 9e271ad66933..6284eaad5f53 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -280,6 +280,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (!queue)
>  		goto no_memory_queue;
>  	queue->close_req = false;
> +	queue->mask = 0xFFFFFFFF;
>  	queue->ida = kzalloc(sizeof(*queue->ida), GFP_KERNEL);
>  	if (!queue->ida)
>  		goto no_memory_queue;
> @@ -449,7 +450,8 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
>  	case PTP_CLOCK_EXTTS:
>  		/* Enqueue timestamp on all other queues */
>  		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
> -			enqueue_external_timestamp(tsevq, event);
> +			if (tsevq->mask & (0x1 << event->index))
> +				enqueue_external_timestamp(tsevq, event);
>  		}
>  		wake_up_interruptible(&ptp->tsev_wq);
>  		break;
> diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
> index 529d3d421ba0..c8ff2272f837 100644
> --- a/drivers/ptp/ptp_private.h
> +++ b/drivers/ptp/ptp_private.h
> @@ -32,6 +32,7 @@ struct timestamp_event_queue {
>  	pid_t reader_pid;
>  	struct ida *ida;
>  	int oid;
> +	int mask;
>  	bool close_req;
>  };
>  
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
> index 05cc35fc94ac..6bbf11dc4a05 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -105,6 +105,15 @@ struct ptp_extts_request {
>  	unsigned int rsv[2]; /* Reserved for future use. */
>  };
>  
> +struct ptp_tsfilter {
> +	union {
> +		unsigned int reader_rpid; /* PID of device user */
> +		unsigned int ndevusers; /* Device user count */
> +	};
> +	int reader_oid; /* Object ID of the timestamp event queue */
> +	unsigned int mask; /* Channel mask. LSB = channel 0 */
> +};
> +
>  struct ptp_perout_request {
>  	union {
>  		/*
> @@ -224,6 +233,9 @@ struct ptp_pin_desc {
>  	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
>  #define PTP_SYS_OFFSET_EXTENDED2 \
>  	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
> +#define PTP_FILTERTS_SET_REQUEST _IOW(PTP_CLK_MAGIC, 19, struct ptp_tsfilter)
> +#define PTP_FILTERCOUNT_REQUEST _IOR(PTP_CLK_MAGIC, 20, int)
> +#define PTP_FILTERTS_GET_REQUEST _IOWR(PTP_CLK_MAGIC, 21, struct ptp_tsfilter)
>

Looking below, at the usability of the API, it feels too complicated, I
was trying to think, "how an application would change the mask for
itself": first it would need to know the PID of the process that created
the fd, then it would have to find the OID associated with that PID, and
then build the request.

And it has the problem of being error prone, for example, it's easy for
an application to override the mask of another, either by mistake or
else.

My suggestion is to keep things simple, the "SET" only receives the
'mask', and it only changes the mask for that particular fd (which you
already did the hard work of allowing that). Seems to be less error prone.

At least in my mental model, I don't think much else is needed (we
expose only a "SET" operation), at least from the UAPI side of things.

For "debugging", i.e. discovering which applications have what masks,
then perhaps we could do it "on the side", for example, a debugfs entry
that lists all open file descriptors and their masks. Just an idea.

What do you think?

>  struct ptp_extts_event {
>  	struct ptp_clock_time t; /* Time event occured. */
> diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
> index c9f6cca4feb4..e7ff22d60d63 100644
> --- a/tools/testing/selftests/ptp/testptp.c
> +++ b/tools/testing/selftests/ptp/testptp.c
> @@ -22,6 +22,7 @@
>  #include <sys/types.h>
>  #include <time.h>
>  #include <unistd.h>
> +#include <stdbool.h>
>  
>  #include <linux/ptp_clock.h>
>  
> @@ -117,35 +118,36 @@ static void usage(char *progname)
>  {
>  	fprintf(stderr,
>  		"usage: %s [options]\n"
> -		" -c         query the ptp clock's capabilities\n"
> -		" -d name    device to open\n"
> -		" -e val     read 'val' external time stamp events\n"
> -		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
> -		" -g         get the ptp clock time\n"
> -		" -h         prints this message\n"
> -		" -i val     index for event/trigger\n"
> -		" -k val     measure the time offset between system and phc clock\n"
> -		"            for 'val' times (Maximum 25)\n"
> -		" -l         list the current pin configuration\n"
> -		" -L pin,val configure pin index 'pin' with function 'val'\n"
> -		"            the channel index is taken from the '-i' option\n"
> -		"            'val' specifies the auxiliary function:\n"
> -		"            0 - none\n"
> -		"            1 - external time stamp\n"
> -		"            2 - periodic output\n"
> -		" -n val     shift the ptp clock time by 'val' nanoseconds\n"
> -		" -o val     phase offset (in nanoseconds) to be provided to the PHC servo\n"
> -		" -p val     enable output with a period of 'val' nanoseconds\n"
> -		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
> -		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
> -		" -P val     enable or disable (val=1|0) the system clock PPS\n"
> -		" -s         set the ptp clock time from the system time\n"
> -		" -S         set the system time from the ptp clock time\n"
> -		" -t val     shift the ptp clock time by 'val' seconds\n"
> -		" -T val     set the ptp clock time to 'val' seconds\n"
> -		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
> -		" -X         get a ptp clock cross timestamp\n"
> -		" -z         test combinations of rising/falling external time stamp flags\n",
> +		" -c           query the ptp clock's capabilities\n"
> +		" -d name      device to open\n"
> +		" -e val       read 'val' external time stamp events\n"
> +		" -f val       adjust the ptp clock frequency by 'val' ppb\n"
> +		" -F [oid,msk] with no arguments, list the users of the device\n"
> +		" -g           get the ptp clock time\n"
> +		" -h           prints this message\n"
> +		" -i val       index for event/trigger\n"
> +		" -k val       measure the time offset between system and phc clock\n"
> +		"              for 'val' times (Maximum 25)\n"
> +		" -l           list the current pin configuration\n"
> +		" -L pin,val   configure pin index 'pin' with function 'val'\n"
> +		"              the channel index is taken from the '-i' option\n"
> +		"              'val' specifies the auxiliary function:\n"
> +		"              0 - none\n"
> +		"              1 - external time stamp\n"
> +		"              2 - periodic output\n"
> +		" -n val       shift the ptp clock time by 'val' nanoseconds\n"
> +		" -o val       phase offset (in nanoseconds) to be provided to the PHC servo\n"
> +		" -p val       enable output with a period of 'val' nanoseconds\n"
> +		" -H val       set output phase to 'val' nanoseconds (requires -p)\n"
> +		" -w val       set output pulse width to 'val' nanoseconds (requires -p)\n"
> +		" -P val       enable or disable (val=1|0) the system clock PPS\n"
> +		" -s           set the ptp clock time from the system time\n"
> +		" -S           set the system time from the ptp clock time\n"
> +		" -t val       shift the ptp clock time by 'val' seconds\n"
> +		" -T val       set the ptp clock time to 'val' seconds\n"
> +		" -x val       get an extended ptp clock time with the desired number of samples (up to %d)\n"
> +		" -X           get a ptp clock cross timestamp\n"
> +		" -z           test combinations of rising/falling external time stamp flags\n",
>  		progname, PTP_MAX_SAMPLES);
>  }
>  
> @@ -162,6 +164,7 @@ int main(int argc, char *argv[])
>  	struct ptp_sys_offset *sysoff;
>  	struct ptp_sys_offset_extended *soe;
>  	struct ptp_sys_offset_precise *xts;
> +	struct ptp_tsfilter tsfilter, *tsfilter_read;
>  
>  	char *progname;
>  	unsigned int i;
> @@ -187,6 +190,7 @@ int main(int argc, char *argv[])
>  	int pps = -1;
>  	int seconds = 0;
>  	int settime = 0;
> +	int rvalue = 0;
>  
>  	int64_t t1, t2, tp;
>  	int64_t interval, offset;
> @@ -194,9 +198,17 @@ int main(int argc, char *argv[])
>  	int64_t pulsewidth = -1;
>  	int64_t perout = -1;
>  
> +	tsfilter_read = NULL;
> +	tsfilter.ndevusers = 0;
> +	tsfilter.reader_oid = 0;
> +	tsfilter.mask = 0xFFFFFFFF;
> +	bool opt_tsfilter = false;
> +
>  	progname = strrchr(argv[0], '/');
>  	progname = progname ? 1+progname : argv[0];
> -	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
> +	while (EOF !=
> +	       (c = getopt(argc, argv,
> +			   "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
>  		switch (c) {
>  		case 'c':
>  			capabilities = 1;
> @@ -210,6 +222,15 @@ int main(int argc, char *argv[])
>  		case 'f':
>  			adjfreq = atoi(optarg);
>  			break;
> +		case 'F':
> +			opt_tsfilter = true;
> +			cnt = sscanf(optarg, "%d,%X", &tsfilter.reader_oid,
> +				     &tsfilter.mask);
> +			if (cnt != 2 && cnt != 0) {
> +				usage(progname);
> +				return -1;
> +			}
> +			break;
>  		case 'g':
>  			gettime = 1;
>  			break;
> @@ -295,7 +316,8 @@ int main(int argc, char *argv[])
>  	clkid = get_clockid(fd);
>  	if (CLOCK_INVALID == clkid) {
>  		fprintf(stderr, "failed to read clock id\n");
> -		return -1;
> +		rvalue = -1;
> +		goto exit;
>  	}
>  
>  	if (capabilities) {
> @@ -464,18 +486,21 @@ int main(int argc, char *argv[])
>  
>  	if (pulsewidth >= 0 && perout < 0) {
>  		puts("-w can only be specified together with -p");
> -		return -1;
> +		rvalue = -1;
> +		goto exit;
>  	}
>  
>  	if (perout_phase >= 0 && perout < 0) {
>  		puts("-H can only be specified together with -p");
> -		return -1;
> +		rvalue = -1;
> +		goto exit;
>  	}
>  
>  	if (perout >= 0) {
>  		if (clock_gettime(clkid, &ts)) {
>  			perror("clock_gettime");
> -			return -1;
> +			rvalue = -1;
> +			goto exit;
>  		}
>  		memset(&perout_request, 0, sizeof(perout_request));
>  		perout_request.index = index;
> @@ -516,13 +541,15 @@ int main(int argc, char *argv[])
>  		if (n_samples <= 0 || n_samples > 25) {
>  			puts("n_samples should be between 1 and 25");
>  			usage(progname);
> -			return -1;
> +			rvalue = -1;
> +			goto exit;
>  		}
>  
>  		sysoff = calloc(1, sizeof(*sysoff));
>  		if (!sysoff) {
>  			perror("calloc");
> -			return -1;
> +			rvalue = -1;
> +			goto exit;
>  		}
>  		sysoff->n_samples = n_samples;
>  
> @@ -604,6 +631,63 @@ int main(int argc, char *argv[])
>  		free(xts);
>  	}
>  
> +	if (opt_tsfilter) {
> +		if (tsfilter.reader_oid) {
> +			/* Set a filter for a specific object id */
> +			if (ioctl(fd, PTP_FILTERTS_SET_REQUEST, &tsfilter)) {
> +				perror("PTP_FILTERTS_SET_REQUEST");
> +				rvalue = -1;
> +				goto exit;
> +			}
> +			printf("Timestamp event queue mask 0x%X applied to reader with oid: %d\n",
> +			       (int)tsfilter.mask, tsfilter.reader_oid);
> +
> +		} else {
> +			/* List all filters */
> +			if (ioctl(fd, PTP_FILTERCOUNT_REQUEST,
> +				  &tsfilter.ndevusers)) {
> +				perror("PTP_FILTERTS_SET_REQUEST");
> +				rvalue = -1;
> +				goto exit;
> +			}
> +			tsfilter_read = calloc(tsfilter.ndevusers,
> +					       sizeof(*tsfilter_read));
> +			/*
> +			 * Get a variable length result from the IOCTL. We use a value
> +			 * inside the structure we are willing to read to communicate the
> +			 * IOCTL how many elements we are expecting to get.
> +			 * It's ok if the size of the list changed between these two operations,
> +			 * this is just an approximation to be able to test the concept.
> +			 */
> +			tsfilter_read[0].ndevusers = tsfilter.ndevusers;
> +			if (!tsfilter_read) {
> +				perror("tsfilter_read calloc");
> +				rvalue = -1;
> +				goto exit;
> +			}
> +			if (ioctl(fd, PTP_FILTERTS_GET_REQUEST,
> +				  tsfilter_read)) {
> +				perror("PTP_FILTERTS_GET_REQUEST");
> +				rvalue = -1;
> +				goto exit;
> +			}
> +			printf("(USER PID)\tTSEVQ FILTER ID:MASK\n");
> +			for (i = 0; i < tsfilter.ndevusers; i++) {
> +				if (tsfilter_read[i].reader_oid)
> +					printf("(%d)\t\t%5d:0x%08X\n",
> +					       tsfilter_read[i].reader_rpid,
> +					       tsfilter_read[i].reader_oid,
> +					       tsfilter_read[i].mask);
> +			}
> +		}
> +	}
> +
> +exit:
> +	if (tsfilter_read) {
> +		free(tsfilter_read);
> +		tsfilter_read = NULL;
> +	}
> +
>  	close(fd);
> -	return 0;
> +	return rvalue;
>  }
> -- 
> 2.34.1
>

-- 
Vinicius

